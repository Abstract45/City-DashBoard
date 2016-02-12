//
//  WeatherForecast.swift
//  Weather Model
//
//  Created by Alexander Besson on 2016-01-22.
//  Copyright © 2016 Alexander Besson. All rights reserved.
//

import Foundation

class WeatherForecast {
    
    // url to form API endpoint link by city: URL_BASE + URL_WEATHER URL_CITY + _city + URL_API + KEY_API
    // url by latitude and longitude: URL_BASE + URL_DAILY + URL_LAT + _latitude + URL_LON + _longitude + URL_API + KEY_API
    private let KEY_API = "decb018311dbd13642d9b8057c789891"
    private let URL_BASE = "http://api.openweathermap.org/data/2.5/"
    private let URL_WEATHER = "weather?"
    private let URL_DAILY = "forecast/daily?"
    private let URL_CITY = "q="
    private let URL_LAT = "lat="
    private let URL_LON = "&lon="
    private let URL_API = "&appid="
    
    private var urlStringT: String = ""
    private var urlStringN: String = ""
    
    internal typealias DownloadComplete = () -> ()
    
    // weather variables for view controller
    private var _weatherToday: WeatherToday?
    private var _weatherNext = [WeatherNext]()
    
    private var _city: String?
    private var _latitude: Double?
    private var _longitude: Double?
    
    var weatherToday: WeatherToday {
        if _weatherToday != nil {
            return _weatherToday!
        } else {
            return WeatherToday(city: "Missing today's weather data.")
        }
    }
    
    var weatherNext: [WeatherNext] {
        return _weatherNext
    }
    
    init(city: String) {
        _city = city
        _weatherNext.append(WeatherNext())
        urlStringT = URL_BASE + URL_WEATHER + URL_CITY + _city! + URL_API + KEY_API
        urlStringN = URL_BASE + URL_DAILY + URL_CITY + _city! + URL_API + KEY_API
    }
    
    init(lat: Double, lon: Double) {
        _latitude = lat
        _longitude = lon
        urlStringT = URL_BASE + URL_WEATHER + URL_LAT + "\(_latitude!)" + URL_LON + "\(_longitude!)" + URL_API + KEY_API
        urlStringN = URL_BASE + URL_DAILY + URL_LAT + "\(_latitude!)" + URL_LON + "\(_longitude!)" + URL_API + KEY_API
    }
    
    func downloadTodaysWeather(completion: DownloadComplete) {
        
        let url = NSURL(string: urlStringT)
        
        _ = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                guard let data = data else {
                    return
                }
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                    
                    if let todaysDict = json as? Dictionary<String, AnyObject> {
                        
                        if let name = todaysDict["name"] as? String {
                            self._weatherToday = WeatherToday(city: name)
                        }
                        
                        if let coord = todaysDict["coord"] as? Dictionary<String, AnyObject> {
                            
                            if let lat = coord["lat"] as? Double {
                                self._weatherToday?.latitude = lat
                            }
                            
                            if let lon = coord["lon"] as? Double {
                                self._weatherToday?.longitude = lon
                            }
                        }
                        
                        if let main = todaysDict["main"] as? Dictionary<String, AnyObject> {
                            
                            if let temp = main["temp"] as? Double {
                                self._weatherToday?.temperatureRaw = temp
                            }
                            
                            if let tempMin = main["temp_min"] as? Double {
                                
                                self._weatherToday?.temperatureMinRaw = tempMin
                            }
                            
                            if let tempMax = main["temp_max"] as? Double {
                               
                                self._weatherToday?.temperatureMaxRaw = tempMax
                            }
                            
                            if let press = main["pressure"] as? Double {
                                self._weatherToday?.pressureRaw = press
                            }
                            
                            if let humid = main["humidity"] as? Double {
                                self._weatherToday?.humidityRaw = humid
                            }
                        }
                        
                        if let clouds = todaysDict["clouds"] as? Dictionary<String,AnyObject> {
                            if let cloudPercent = clouds["all"] as? Double {
                                self.weatherToday.cloudCoverageRaw = cloudPercent
                            }
                        }
                        
                        if let wind = todaysDict["wind"] as? Dictionary<String, AnyObject> {
                            
                            if let speed = wind["speed"] as? Double {
                                self._weatherToday?.windSpeedRaw = speed
                            }
                            
                            if let direction = wind["deg"] as? Double {
                                self._weatherToday?.windDirectionRaw = direction
                            }
                        }
                        
                        if let weather = todaysDict["weather"] as? Array<AnyObject> {
                            
                            if let weatherDict = weather[0] as? Dictionary<String, AnyObject> {
                                
                                if let descShort = weatherDict["main"] as? String {
                                    self._weatherToday?.descriptionShort = descShort
                                }
                                
                                if let descLong = weatherDict["description"] as? String {
                                    self._weatherToday?.descriptionLong = descLong
                                }
                            }
                        }
                        
                        if let sys = todaysDict["sys"] as? Dictionary<String, AnyObject> {
                            
                            if let countryItem = sys["country"] as? String {
                                self._weatherToday?.country = countryItem
                            }
                            
                            if let sunR = sys["sunrise"] as? Double {
                                self._weatherToday?.sunriseDouble = sunR
                            }
                            
                            if let sunS = sys["sunset"] as? Double {
                                self._weatherToday?.sunsetDouble = sunS
                            }
                        }
                    
                    }
                    
                } catch {
                    print("Could not serialize JSON for today's weather link.")
                }
                
                completion()
                
            })
            
            }.resume()
    }
    
    func downloadWeeklyForecast(completion: DownloadComplete) {
        
        _weatherNext.removeAll()
                
        var wCity = ""
        var wCountry = ""
        var wLatitude: Double = 0
        var wLongitude: Double = 0
        
        let url = NSURL(string: urlStringN)
        
        _ = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                guard let data = data else {
                    return
                }
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                    
                    if let forecastDict = json as? Dictionary<String, AnyObject> {
                        
                        if let city = forecastDict["city"] as? Dictionary<String, AnyObject> {
                            
                            if let name = city["name"] as? String {
                                wCity = name
                            }
                            
                            if let coord = city["coord"] as? Dictionary<String, AnyObject> {
                                
                                if let lat = coord["lat"] as? Double {
                                    wLatitude = lat
                                }
                                
                                if let lon = coord["lon"] as? Double {
                                    wLongitude = lon
                                }
                            }
                            
                            if let countryName = city["country"] as? String {
                                wCountry = countryName
                            }
                        }
                        
                        if let list = forecastDict["list"] as? Array<AnyObject> {
                            
                            for l in (list as? [Dictionary<String, AnyObject>])! {
                                
                                let wNext = WeatherNext()
                                wNext.city = wCity
                                wNext.country = wCountry
                                wNext.latitude = wLatitude
                                wNext.longitude = wLongitude
                                
                                if let item = l as? Dictionary<String, AnyObject> {
                                    
                                    if let temp = item["temp"] as? Dictionary<String, AnyObject> {
                                        
                                        if let tempDay = temp["day"] as? Double {
                                            wNext.temperatureRaw = tempDay
                                        }
                                        
                                        if let tempMin = temp["min"] as? Double {
                                            wNext.temperatureMinRaw = tempMin
                                        }
                                        
                                        if let tempMax = temp["max"] as? Double {
                                            wNext.temperatureMaxRaw = tempMax
                                        }
                                        
                                        if let tempEve = temp["eve"] as? Double {
                                            wNext.temperatureEveningRaw = tempEve
                                        }
                                        
                                        if let tempNight = temp["night"] as? Double {
                                            wNext.temperatureNightRaw = tempNight
                                        }
                                        
                                        if let tempMorn = temp["morn"] as? Double {
                                            wNext.temperatureMorningRaw = tempMorn
                                        }
                                    }
                                    
                                    if let press = item["pressure"] as? Double {
                                        wNext.pressureRaw = press
                                    }
                                    
                                    if let humid = item["humidity"] as? Double {
                                        wNext.humidityRaw = humid
                                    }
                                    
                                    if let windS = item["speed"] as? Double {
                                        wNext.windSpeedRaw = windS
                                    }
                                    
                                    if let windD = item["deg"] as? Double {
                                        wNext.windDirectionRaw = windD
                                    }
                                    
                                    if let cloud = item["clouds"] as? Double {
                                        wNext.cloudCoverageRaw = cloud
                                    }
                                    
                                    if let weather = item["weather"] as? Array<AnyObject> {
                                        
                                        if let weatherItem = weather[0] as? Dictionary<String, AnyObject> {
                                            
                                            if let descShort = weatherItem["main"] as? String {
                                                wNext.descriptionShort = descShort
                                            }
                                            
                                            if let descLong = weatherItem["description"] as? String {
                                                wNext.descriptionLong = descLong
                                            }
                                        }
                                    }
                                    
                                    self._weatherNext.append(wNext)
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                } catch {
                    
                    print("Could not serialize JSON for weekly forecast link.")
                }
                
                completion()
                
            })
            
        }).resume()
        
    }
    
}