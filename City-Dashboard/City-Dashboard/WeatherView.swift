//
//  WeatherView.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-26.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherView: UIView, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    var locManager = CLLocationManager()
    
    @IBOutlet weak var imgWeatherLogo: UIImageView!
    @IBOutlet weak var lblWeatherCategory: UILabel!
    @IBOutlet weak var logoRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblHumidityPercent: UILabel!
    @IBOutlet weak var lblWindSpeed: UILabel!
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblSunsetTime: UILabel!
    @IBOutlet weak var lblCloudPercent: UILabel!
    @IBOutlet weak var forecastView: UIView!
    
    @IBOutlet weak var lblWeatherDescription: UILabel!
    @IBOutlet weak var imgCurrentWeatherIcon: UIImageView!
    @IBOutlet weak var weatherTable: UITableView!
    @IBOutlet weak var lblCurrentTempMin: UILabel!
    @IBOutlet weak var lblCurrentTempMax: UILabel!
    @IBOutlet weak var lblSunriseTime: UILabel!
    private var view: UIView!
    
    var wToday = WeatherToday()
    var wNext = [WeatherNext()]
    
    private var currentWeekDays = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureLocationManager()
       
//        populateWeeklyForecastLabels()
//        populateWeatherLabels()
    }
    
    private func xibSetup() {
        view = loadViewFromNib()
        
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "WeatherView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wNext.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        weatherTable.registerNib(UINib.init(nibName: "WeatherTableCell", bundle: nil), forCellReuseIdentifier:"weather")
        let cell = weatherTable.dequeueReusableCellWithIdentifier("weather") as! WeatherTableCell
        cell.weekday.text = currentWeekDays[indexPath.row]
        cell.tempMin.text = wNext[indexPath.row].temperatureMin
        cell.tempMax.text = wNext[indexPath.row].temperatureMax
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 35
    }

    
    private  func cofigLayerView() {
        weatherTable.layer.cornerRadius = 10
        weatherTable.clipsToBounds = true
        
        forecastView.layer.cornerRadius = 10
        forecastView.clipsToBounds = true
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
    
    func configWeatherView() {
        lblCity.text = wToday.city
        lblCloudPercent.text = wToday.cloudCoverage
        lblCurrentTemp.text = wToday.temperature + "c"
        
        lblCurrentTempMin.text = wToday.temperatureMin
        lblCurrentTempMax.text = wToday.temperatureMax
        lblHumidityPercent.text = wToday.humidity
        lblWindSpeed.text = wToday.windSpeed
        lblSunriseTime.text = wToday.sunrise
        lblSunsetTime.text = wToday.sunset
        lblWeatherDescription.text = wToday.descriptionLong
        
        lblCloudPercent.text = wToday.cloudCoverage
        lblPressure.text = wToday.pressure
 
    }
    
    
    func getDaysOfWeek(numOfDays:Int) -> [String] {
        
        let calendar = NSCalendar.currentCalendar()
        let date = NSDate()
        let week = calendar.components([.Weekday], fromDate: date)
        var todayIs = week.weekday
        var index = 0
        print(todayIs)
        
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
    
}
