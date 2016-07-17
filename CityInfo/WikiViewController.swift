//
//  WikiViewController.swift
//  Chapter 2 City Info
//
//  Created by Mini Projects on 02/05/2015.
//  Copyright (c) 2015 Packt Pub. All rights reserved.
//

import Foundation
import UIKit

class WikiViewController:UIViewController {
    var cityInfo:CityInfo!
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        let url:NSURL
        if let wikipediaInfo = self.cityInfo.wikipedia {
            url = NSURL(string: "http://\(wikipediaInfo)")!
        }else {
            url = NSURL(string:"http://en.wikipedia.org/w/index.php?search=\(self.cityInfo.name)")!
        }
        let request = NSURLRequest(URL: url)
        self.webView.loadRequest(request)
    }
    
}
