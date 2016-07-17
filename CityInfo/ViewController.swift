//
//  ViewController.swift
//  CityInfo
//
//  Created by Firoz Ansari on 10/02/2016.
//  Copyright © 2016 Firoz Ansari. All rights reserved.
//

import UIKit
import CoreLocation

class InitialViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var locationManager = CLLocationManager()
    private var cities = [CityInfo]()
    private var citiesDisplayed = [CityInfo]()
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.distanceFilter = 3000
        if locationManager.respondsToSelector(Selector("requestWhenInUseAuthorization")) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let lastLocation = locations.last!
        print(lastLocation)
        let accurrancy = 0.2
        requestJSON("http://api.geonames.org/citiesJSON", params: [
            "north":"\(lastLocation.coordinate.latitude + accurrancy)",
            "south":"\(lastLocation.coordinate.latitude - accurrancy)",
            "east":"\(lastLocation.coordinate.longitude + accurrancy)",
            "west":"\(lastLocation.coordinate.longitude - accurrancy)",
            "lang":"en",
            "username":"firozansar"
        ]) { (json, error) -> Void in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            if let status = json["status"].dictionary {
                print("Error")
            }else if let cities = json["geonames"].array {
                self.citiesDisplayed = [CityInfo]()
                self.cities = cities.reduce([CityInfo]()) { (citiesInfo, json) -> [CityInfo] in
                    var citiesCopy = citiesInfo
                    if let cityInfo = CityInfo(json: json) {
                        citiesCopy.append(cityInfo)
                        self.citiesDisplayed.append(cityInfo)
                    }
                    return citiesCopy
                }
                
                M {
                    self.tableView.reloadData()
                }
            }else {
                print("error")
            }
        }
    }
    
    // MARK: - TableView Datasource and delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.citiesDisplayed.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cityinfocell") as! CityInfoCell
        cell.cityInfo = self.citiesDisplayed[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("cityoptions") as! CityOptionsViewController
        viewController.cityInfo = self.citiesDisplayed[indexPath.row]
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    // MARK: - UISearchBar delegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.citiesDisplayed = [CityInfo]()
        for cityInfo in self.cities {
            if searchText == "" {
                citiesDisplayed.append(cityInfo)
            }else if cityInfo.name.lowercaseString.rangeOfString(searchText.lowercaseString) != nil{
                citiesDisplayed.append(cityInfo)
            }
        }
        self.tableView.reloadData()
    }
    
}

