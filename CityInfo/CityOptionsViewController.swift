//
//  CityOptionsViewController.swift
//  Chapter 2 City Info
//
//  Created by Mini Projects on 02/05/2015.
//  Copyright (c) 2015 Packt Pub. All rights reserved.
//

import Foundation
import UIKit

class CityOptionsViewController : UIPageViewController, UIPageViewControllerDataSource {
    var cityInfo:CityInfo!
    private var cityViewControllers = [UIViewController]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.doubleSided = false
        let wikiViewController = self.storyboard?.instantiateViewControllerWithIdentifier("wikicity") as! WikiViewController
        wikiViewController.cityInfo = self.cityInfo
        cityViewControllers.append(wikiViewController)
        
        let weatherViewController = self.storyboard?.instantiateViewControllerWithIdentifier("weathercity") as! WeatherViewController
        weatherViewController.cityInfo = cityInfo
        cityViewControllers.append(weatherViewController)
        
        let picturesViewController = self.storyboard?.instantiateViewControllerWithIdentifier("picturescity") as! PicturesViewController
        picturesViewController.cityInfo = cityInfo
        cityViewControllers.append(picturesViewController)
        
        self.setViewControllers([wikiViewController], direction: .Forward, animated: true) { (_) -> Void in
            return
        }

    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let position = cityViewControllers.indexOf(viewController) where position > 0{
            return cityViewControllers[position - 1]
        }
        return nil
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let position = cityViewControllers.indexOf(viewController) where position < cityViewControllers.count - 1 {
            return cityViewControllers[position + 1]
        }
        return nil
    }
    


}