//
//  WeatherToday.swift
//  Weather Model
//
//  Created by Alexander Besson on 2016-01-22.
//  Copyright © 2016 Alexander Besson. All rights reserved.
//

import Foundation

class WeatherToday: Weather {
    
    // sunrise and sunset
    private var _sunrise: Double?
    private var _sunset: Double?
    
    var sunriseDouble: Double {
        get {
            if _sunrise != nil {
                return _sunrise!
            } else {
                print("Sunrise value is nil in Weather Today object.")
                return 0
            }
        }
        set(newValue) {
            _sunrise = newValue
        }
    }
    
    var sunrise: String {
        if _sunrise != nil {
            return timeReadable(_sunrise!)
        } else {
            print("Sunrise value is nil in Weather Today object.")
            return ""
        }
    }
    
    var sunsetDouble: Double {
        get {
            if _sunset != nil {
                return _sunset!
            } else {
                print("Sunset value nil in Weather Today object.")
                return 0
            }
        }
        set(newValue) {
            _sunset = newValue
        }
    }
    
    var sunset: String {
        if _sunset != nil {
            return timeReadable(_sunset!)
        } else {
            print("Sunset value nil in Weather Today object.")
            return ""
        }
    }
    
    override init(city: String) {
        super.init(city: city)
    }
    
    override init(lat: Double, lon: Double) {
        super.init(lat: lat, lon: lon)
    }
    
    func timeReadable(time:Double) -> String{
        let date = NSDate(timeIntervalSince1970: time)
        let dateString = String(date)
        let timeString = String(dateString.characters.dropLast(9).dropFirst(11))
        
        return timeString
    }
    
}