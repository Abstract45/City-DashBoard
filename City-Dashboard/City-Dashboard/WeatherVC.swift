//
//  WeatherVC.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-31.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var weatherTable: UITableView!
    
    @IBOutlet var weatherMainView: WeatherView!
    
    var wToday = WeatherToday()
    var wNext = [WeatherNext()]
    var locManager = CLLocationManager()
    private var currentWeekDays = [String]()
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
       weatherTable.registerNib(UINib(nibName: "WeatherTableCell", bundle: nil), forCellReuseIdentifier: "weather")
        
       
        configureLocationManager()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeWeatherXib:", name: "changeTopView", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetWeatherXib:", name: "resetViews", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "topOpen:", name: "topViewOpen", object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    
    func changeWeatherXib(notification:NSNotification) {
        UIView.animateWithDuration(1) { () -> Void in
            
            self.weatherMainView.vwWeatherToday.alpha = 0
            self.weatherMainView.logoRightConstraint.constant = ConstraintSize.midSizeLogo
            self.view.layoutIfNeeded()
        }
    }
    
    
    func topOpen(notification:NSNotification) {
        
   
        UIView.animateWithDuration(1) { () -> Void in
           
            self.weatherMainView.forecastView.alpha = 1
            self.weatherTable.alpha = 1
            self.weatherMainView.lblWeatherCategory.alpha = 0
            self.weatherMainView.imgWeatherLogo.alpha = 0
           
            
        }
    }
    
    func resetWeatherXib(notification:NSNotification) {
       UIView.animateWithDuration(1) { () -> Void in
        self.weatherMainView.logoRightConstraint.constant = 22
        self.weatherMainView.forecastView.alpha = 0
        self.weatherTable.alpha = 0
        self.weatherMainView.lblWeatherCategory.alpha = 1
        self.weatherMainView.imgWeatherLogo.alpha = 1
        self.view.backgroundColor = UIColor(red: 67/255, green: 151/255, blue: 219/255, alpha: 1)
        self.weatherMainView.vwWeatherToday.alpha = 1
        self.view.layoutIfNeeded()
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
       
       
         let cell = weatherTable.dequeueReusableCellWithIdentifier("weather") as! WeatherTableCell
        
        if !currentWeekDays.isEmpty {
            cell.weekday.text = currentWeekDays[indexPath.row]
            
            cell.tempMin.text = wNext[indexPath.row].temperatureMin
            cell.tempMax.text = wNext[indexPath.row].temperatureMax
        }
      
        cell.layoutIfNeeded()
        cell.layoutSubviews()
        
        return cell
    }
    
    
  
    private  func cofigLayerView() {
        weatherTable.layer.cornerRadius = 10
        weatherTable.clipsToBounds = true
        
        self.weatherMainView.forecastView.layer.cornerRadius = 10
        self.weatherMainView.forecastView.clipsToBounds = true
    }
    
    func populateWeatherLabels(city: String, lat: Double, lon: Double) -> WeatherToday {
        
        let weatherToday = WeatherForecast(lat: lat, lon: lon)
        
        weatherToday.downloadTodaysWeather { () -> () in
            
            self.wToday = weatherToday.weatherToday
            self.configWeatherView()
            self.view.layoutIfNeeded()
            
        }
        
        return self.wToday
    }
    
    func populateWeeklyForecastLabels(city: String, lat: Double, lon: Double) -> [WeatherNext] {
        
        let weatherNext = WeatherForecast(lat: lat, lon: lon)
        
        weatherNext.downloadWeeklyForecast { () -> () in
            
            self.wNext = weatherNext.weatherNext
            
            self.currentWeekDays = self.getDaysOfWeek(self.wNext.count)
            
            self.weatherTable.reloadData()
    
        }
        
        
        return self.wNext
    }
    
    func getDaysOfWeek(numOfDays:Int) -> [String] {
        
        let calendar = NSCalendar.currentCalendar()
        let date = NSDate()
        let week = calendar.components([.Weekday], fromDate: date)
        var todayIs = week.weekday
        var index = 0
      
        
        let weekdays = ["","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
        var forecastDays = [String]()
        
        var findTomorrow = ""
        for _ in 0..<numOfDays {
            
            if todayIs < 7 {
                index = todayIs.advancedBy(1)
                
            } else {
                index = 1
            }
            
            
            findTomorrow = weekdays[index]
            todayIs = weekdays.indexOf(findTomorrow)!
            if todayIs == 7 {
                todayIs = 0
            }
            forecastDays.append(findTomorrow)
            
            
        }
        return forecastDays
    }
    // Location function
    
    func configureLocationManager() {
        locManager = CLLocationManager()
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        locManager.requestLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locManager.stopUpdatingLocation()
        
        let userLocation = locations[0]
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            
            if error != nil {
                
                print("Error " + error!.localizedDescription)
                
            } else {
                
                if placemarks != nil {
                    
                    let p = CLPlacemark(placemark: placemarks![0])
                    
                    if p.subAdministrativeArea != nil {
                        
                        
                        self.populateWeeklyForecastLabels(p.subAdministrativeArea!, lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude)
                        
                        self.populateWeatherLabels(p.subAdministrativeArea!, lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude)
                        
                        
                    }
                    
                }
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
    }
    
    func configWeatherView() {
        self.weatherMainView.lblCity.text = wToday.city
        self.weatherMainView.lblCloudPercent.text = wToday.cloudCoverage
        self.weatherMainView.lblCurrentTemp.text = wToday.temperature + "c"
        
        self.weatherMainView.lblCurrentTempMin.text = wToday.temperatureMin
        self.weatherMainView.lblCurrentTempMax.text = wToday.temperatureMax
        self.weatherMainView.lblHumidityPercent.text = wToday.humidity
        self.weatherMainView.lblWindSpeed.text = wToday.windSpeed
        self.weatherMainView.lblSunriseTime.text = wToday.sunrise
        self.weatherMainView.lblSunsetTime.text = wToday.sunset
        self.weatherMainView.lblWeatherDescription.text = wToday.descriptionLong
        
        self.weatherMainView.lblCloudPercent.text = wToday.cloudCoverage
        self.weatherMainView.lblPressure.text = wToday.pressure
        
    }
    
    
    
    
    
    
    
}
