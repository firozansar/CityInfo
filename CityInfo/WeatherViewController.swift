//
//  WeatherViewController.swift
//  Chapter 2 City Info
//
//  Created by Mini Projects on 02/05/2015.
//  Copyright (c) 2015 Packt Pub. All rights reserved.
//

import Foundation
import UIKit

class WeatherViewController:UIViewController, UITableViewDataSource {
    
    var cityInfo:CityInfo!
    var forecast = [JSON]()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        requestJSON("http://api.openweathermap.org/data/2.5/forecast",
            params: ["lat": "\(cityInfo.lat)",
                "lon": "\(cityInfo.lng)"]) { (json, error) -> Void in
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    }
                    self.forecast = json["list"].arrayValue
                    M {
                        self.tableView.reloadData()
                    }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return forecast.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let currentForecast = forecast[indexPath.row]
        var cell:WeatherCell
        if let rain = currentForecast["rain"]["3h"].double where rain > 0 {
            cell = tableView.dequeueReusableCellWithIdentifier("raincell") as! RainCell
            
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier("weathercell") as! WeatherCell
        }
        cell.setUIFromJSON(currentForecast)
        return cell
    }
}
