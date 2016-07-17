//
//  RainCell.swift
//  Chapter 2 City Info
//
//  Created by Mini Projects on 07/05/2015.
//  Copyright (c) 2015 Packt Pub. All rights reserved.
//

import Foundation
import UIKit

class RainCell:WeatherCell {
    @IBOutlet var waterLabel: UILabel!

    override func setUIFromJSON(json:JSON){
        super.setUIFromJSON(json)
        self.icon.image = UIImage(named:"rain")
        self.waterLabel.text = String(format: "%.02fmm",json["rain"]["3h"].doubleValue)
    }
}