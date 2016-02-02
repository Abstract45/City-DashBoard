//
//  WeatherNext.swift
//  Weather Model
//
//  Created by Alexander Besson on 2016-01-22.
//  Copyright © 2016 Alexander Besson. All rights reserved.
//

import Foundation

class WeatherNext: Weather {
    
    // additional temperature info
    private var _temperatureNight: Double?
    private var _temperatureEvening: Double?
    private var _temperatureMorning: Double?
    
    var temperatureNightRaw: Double {
        get {
            if _temperatureNight != nil {
                return _temperatureNight!
            } else {
                return 0
            }
        }
        set(newValue) {
            _temperatureNight = newValue
        }
    }
    
    var temperatureNight: String {
        if _temperatureNight != nil {
            return kelvinToCelciusToString(_temperatureNight!)
        } else {
            return ""
        }
    }
    
    var temperatureEveningRaw: Double {
        get {
            if _temperatureEvening != nil {
                return _temperatureEvening!
            } else {
                return 0
            }
        }
        set(newValue) {
            _temperatureEvening = newValue
        }
    }
    
    var temperatureEvening: String {
        if _temperatureEvening != nil {
            return kelvinToCelciusToString(_temperatureEvening!)
        } else {
            return ""
        }
    }
    
    var temperatureMorningRaw: Double {
        get {
            if _temperatureMorning != nil {
                return _temperatureMorning!
            } else {
                return 0
            }
        }
        set(newValue) {
            _temperatureMorning = newValue
        }
    }
    
    var temperatureMorning: String {
        if _temperatureMorning != nil {
            return kelvinToCelciusToString(_temperatureMorning!)
        } else {
            return ""
        }
    }
    
    override init(city: String) {
        super.init(city: city)
    }
    
    override init(lat: Double, lon: Double) {
        super.init(lat: lat, lon: lon)
    }
    
    override init() {
        super.init()
    }
}