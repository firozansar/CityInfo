//
//  CityInfoCell.swift
//  Chapter 2 City Info
//
//  Created by Mini Projects on 04/05/2015.
//  Copyright (c) 2015 Packt Pub. All rights reserved.
//

import UIKit

class CityInfoCell:UITableViewCell {
    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var coordinates:UILabel!
    @IBOutlet var population:UILabel!
    @IBOutlet var infoImage:UIImageView!
    
    private var _cityInfo:CityInfo!
    var cityInfo:CityInfo {
        get {
            return _cityInfo
        }
        set (cityInfo){
            self._cityInfo = cityInfo
            self.nameLabel.text = cityInfo.name
            if let population = cityInfo.population {
                self.population.text = "Pop: \(population)"
            }else {
                self.population.text = ""
            }
            
            self.coordinates.text = String(format: "%.02f, %.02f", cityInfo.lat, cityInfo.lng)
            
            if let _ = cityInfo.wikipedia  {
                self.infoImage.image = UIImage(named: "info")
            }
        }
    }
}

