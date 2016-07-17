//
//  PicturesViewController.swift
//  Chapter 2 City Info
//
//  Created by Mini Projects on 02/05/2015.
//  Copyright (c) 2015 Packt Pub. All rights reserved.
//

import UIKit

class PicturesViewController: UICollectionViewController {
    
    private class PhotoInfo {
        var title:String!
        var url:String!
        var localPath:String!
        var id:String!
    }
    
    var cityInfo:CityInfo!
    private var photos = [PhotoInfo]()
    
    
    override func viewDidLoad() {
        let params:[String:String] = [
            "method": "flickr.photos.search",
            "api_key": "8b799bddbc620b3ad9cdeb75a047c7e9",
            "text": cityInfo.name,
            "format": "json",
            "extras": "url_t"
        ]
        
        
        requestJSON("https://api.flickr.com/services/rest", params: params) { (json, error) -> Void in
            for photo in json["photos"]["photo"].arrayValue {
                if let url = photo["url_t"].string {
                    let photoInfo = PhotoInfo()
                    photoInfo.url = url
                    photoInfo.title = photo["title"].stringValue
                    photoInfo.id = photo["id"].stringValue
                    let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
                    photoInfo.localPath = (documentDirectory as NSString).stringByAppendingPathComponent("\(photoInfo.id).png")
                    self.photos.append(photoInfo)
                    
                    if let url = NSURL(string: url){
                        NSURLSession.sharedSession().downloadTaskWithURL(url){ (url, response, error) in
                            let urlTarget = NSURL(fileURLWithPath: photoInfo.localPath)
                            do {
                                try NSFileManager.defaultManager().moveItemAtURL(url!, toURL: urlTarget)
                            } catch _ {
                            }
                            M{
                                self.collectionView?.reloadData()
                            }
                            }.resume()
                    }
                }
            }
        }
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("picturecell", forIndexPath: indexPath) as! PictureCell
        
        if let data = NSData(contentsOfFile: photos[indexPath.row].localPath) {
            cell.picture.image =  UIImage(data: data)
        }
        cell.text.text = photos[indexPath.row].title
        
        return cell
    }
}