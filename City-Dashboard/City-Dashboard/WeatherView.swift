//
//  WeatherView.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-26.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

 class WeatherView: UIView, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var logoRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblHumidityPercent: UILabel!
    @IBOutlet weak var lblWindSpeed: UILabel!
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var lblSnowPercent: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblSunsetTime: UILabel!
    @IBOutlet weak var lblCloudPercent: UILabel!
    @IBOutlet weak var forecastView: UIView!
    
    @IBOutlet weak var lblWeatherDescription: UILabel!
    @IBOutlet weak var imgCurrentWeatherIcon: UIImageView!
    @IBOutlet weak var weatherTable: UITableView!
    @IBOutlet weak var lblCurrentTempMinMax: UILabel!
    @IBOutlet weak var lblSunriseTime: UILabel!
    private var view: UIView!
    
    var wToday = WeatherToday(city: "Toronto")
    var wNext = [WeatherNext]()
    
    private var currentWeekDays = [String]()
    private var weeklyMinMaxTemps = [String]()
    
   
    
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
        currentWeekDays = ["Monday","Tuesday","Wednesday","Thursday","Friday"]
        weeklyMinMaxTemps = ["-1*  2*"," 1*  4*", "-9* -1*", "-7* -5*", " 0*  3*"]
        populateWeeklyForecastLabels()
        populateWeatherLabels()
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
        cell.weekday.text = ""
        cell.tempMinMax.text = "\(wNext[indexPath.row].temperatureMin)\(wNext[indexPath.row].temperatureMax))"
        return cell
    }
    
    private  func cofigLayerView() {
        weatherTable.layer.cornerRadius = 10
        weatherTable.clipsToBounds = true
     
        forecastView.layer.cornerRadius = 10
        forecastView.clipsToBounds = true
    }
    
    func populateWeatherLabels() -> WeatherToday {
        
        
        
        let weatherToday = WeatherForecast(city: "Toronto")
        
        weatherToday.downloadTodaysWeather { () -> () in
            
            self.wToday = weatherToday.weatherToday
            
        }
        
        return self.wToday
    }
    
    func populateWeeklyForecastLabels() -> [WeatherNext] {

        let weatherNext = WeatherForecast(city: "Toronto")
        
        weatherNext.downloadWeeklyForecast { () -> () in
            
            self.wNext = weatherNext.weatherNext
            
            print(self.wNext)
            self.weatherTable.reloadData()
        }
        
        return self.wNext
    }
    
    func configWeatherView() {
        
    }
    
}
