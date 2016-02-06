//
//  WeatherVC.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-31.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {
    
    
    @IBOutlet var weatherMainView: WeatherView!
     private var midSize:CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.midSize = self.weatherMainView.frame.midX - 51.5
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeWeatherXib:", name: "changeTopView", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetWeatherXib:", name: "resetViews", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "topOpen:", name: "topViewOpen", object: nil)
    }
    
    func changeWeatherXib(notification:NSNotification) {
        UIView.animateWithDuration(1) { () -> Void in
            self.weatherMainView.logoRightConstraint.constant = self.midSize
        
            self.view.layoutIfNeeded()
        }
    }
    
    
    func topOpen(notification:NSNotification) {
        UIView.animateWithDuration(1) { () -> Void in
            self.weatherMainView.forecastView.alpha = 1
            self.weatherMainView.weatherTable.alpha = 1
            self.weatherMainView.lblWeatherCategory.alpha = 0
            self.weatherMainView.imgWeatherLogo.alpha = 0
            self.view.backgroundColor = UIColor.clearColor()
        }
    }
    
    func resetWeatherXib(notification:NSNotification) {
       UIView.animateWithDuration(1) { () -> Void in
        self.weatherMainView.logoRightConstraint.constant = 22
        self.weatherMainView.forecastView.alpha = 0
        self.weatherMainView.weatherTable.alpha = 0
        self.weatherMainView.lblWeatherCategory.alpha = 1
        self.weatherMainView.imgWeatherLogo.alpha = 1
        self.view.backgroundColor = UIColor(red: 58/255, green: 55/255, blue: 51/255, alpha: 1)
        self.view.layoutIfNeeded()
        }
    }
    
    
    
    
    
    
    
    
    
    
}
