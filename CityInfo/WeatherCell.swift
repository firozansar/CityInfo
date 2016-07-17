//
//  NoRainCell.swift
//  Chapter 2 City Info
//
//  Created by Mini Projects on 07/05/2015.
//  Copyright (c) 2015 Packt Pub. All rights reserved.
//

import UIKit

class WeatherCell:UITableViewCell{
    
    @IBOutlet var tempMax: UILabel!
    @IBOutlet var dateAndTime: UILabel!
    @IBOutlet var icon: UIImageView!
    
    func setUIFromJSON(json:JSON){
        let date = json["dt_txt"].stringValue
        let hour = Int(date.componentsSeparatedByString(" ")[1].componentsSeparatedByString(":")[0])!
        if hour > 5 && hour < 20 {
            self.icon.image = UIImage(named:"sun")
        } else {
            self.icon.image = UIImage(named:"moon")
        }
        self.tempMax.text = String(format:"%.01fC", json["main"]["temp_max"].doubleValue - 272.15)
        self.dateAndTime.text = date
    }
}