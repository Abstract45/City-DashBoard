//
//  Weather.swift
//  Weather Model
//
//  Created by Alexander Besson on 2016-01-22.
//  Copyright © 2016 Alexander Besson. All rights reserved.
//

import Foundation

class Weather {
    
    // location
    private var _city: String?
    private var _country: String?
    private var _latitude: Double?
    private var _longitude: Double?
    
    var city: String {
        get {
            if _city != nil {
                return _city!
            } else {
                return ""
            }
        }
        set(newValue) {
            _city = newValue
        }
    }
    
    var country: String {
        get {
            if _country != nil {
                return _country!
            } else {
                return ""
            }
        }
        set(newValue) {
            _country = newValue
        }
    }
    
    var latitude: Double {
        get {
            if _latitude != nil {
                return _latitude!
            } else {
                return 0
            }
        }
        set(newValue) {
            _latitude = newValue
        }
    }
    
    var longitude: Double {
        get {
            if _longitude != nil {
                return _longitude!
            } else {
                return 0
            }
        }
        set(newValue) {
            _longitude = newValue
        }
    }
    
    // weather info
    private var _temperature: Double?
    private var _temperatureMin: Double?
    private var _temperatureMax: Double?
    
    var temperatureRaw: Double {
        get {
            if _temperature != nil {
                return _temperature!
            } else {
                return 0
            }
        }
        set(newValue) {
            _temperature = newValue
        }
    }
    
    var temperature: String {
        if _temperature != nil {
            return kelvinToCelciusToString(_temperature!)
        } else {
            return ""
        }
    }
    
    var temperatureMinRaw: Double {
        get {
            if _temperatureMin != nil {
                return _temperatureMin!
            } else {
                return 0
            }
        }
        set(newValue) {
            _temperatureMin = newValue
        }
    }
    
    var temperatureMin: String {
        if _temperatureMin != nil {
            return kelvinToCelciusToString(_temperatureMin!)
        } else {
            return ""
        }
    }
    
    var temperatureMaxRaw: Double {
        get {
            if _temperatureMax != nil {
                return _temperatureMax!
            } else {
                return 0
            }
        }
        set(newValue) {
            _temperatureMax = newValue
        }
    }
    
    var temperatureMax: String {
        if _temperatureMax != nil {
            return kelvinToCelciusToString(_temperatureMax!)
        } else {
            return ""
        }
    }
    
    // more weather info
    private var _pressure: Double?
    private var _humidity: Double?
    private var _windSpeed: Double?
    private var _windDirection: Double?
    private var _cloudCoverage: Double?
    
    var pressureRaw: Double {
        get {
            if _pressure != nil {
                return _pressure!
            } else {
                return 0
            }
        }
        set(newValue) {
            _pressure = newValue
        }
    }
    
    var pressure: String {
        if _pressure != nil {
            return hectopascalsToKilopascalsToString(_pressure!)
        } else {
            return ""
        }
    }
    
    var humidityRaw: Double {
        get {
            if _humidity != nil {
                return _humidity!
            } else {
                return 0
            }
        }
        set(newValue) {
            _humidity = newValue
        }
    }
    
    var humidity: String {
        if _humidity != nil {
            return "\(Int(_humidity!)) %"
        } else {
            return ""
        }
    }
    
    var windSpeedRaw: Double {
        get {
            if _windSpeed != nil {
                return _windSpeed!
            } else {
                return 0
            }
        }
        set(newValue) {
            _windSpeed = newValue
        }
    }
    
    var windSpeed: String {
        if _windSpeed != nil {
            return "\(_windSpeed!) m/s"
        } else {
            return ""
        }
    }
    
    var windDirectionRaw: Double {
        get {
            if _windDirection != nil {
                return _windDirection!
            } else {
                return 0
            }
        }
        set(newValue) {
            _windDirection = newValue
        }
    }
    
    var windDirection: String {
        if _windDirection != nil {
            return degreesToDirectionToString(_windDirection!)
        } else {
            return ""
        }
    }
    
    var cloudCoverageRaw: Double {
        get {
            if _cloudCoverage != nil {
                return _cloudCoverage!
            } else {
                return 0
            }
        }
        set(newValue) {
            _cloudCoverage = newValue
        }
    }
    
    var cloudCoverage: String {
        if _cloudCoverage != nil {
            return "\(Int(_cloudCoverage!)) %"
        } else {
            return ""
        }
    }
    
    // description of conditions
    private var _descriptionShort: String?
    private var _descriptionLong: String?
    
    var descriptionShort: String {
        get {
            if _descriptionShort != nil {
                return _descriptionShort!
            } else {
                return ""
            }
        }
        set(newValue) {
            _descriptionShort = newValue
        }
    }
    
    var descriptionLong: String {
        get {
            if _descriptionLong != nil {
                return _descriptionLong!.uppercaseString
            } else {
                return ""
            }
        }
        set(newValue) {
            _descriptionLong = newValue
        }
    }
    
    init(city: String) {
        self.city = city
    }
    
    init(lat: Double, lon: Double) {
        latitude = lat
        longitude = lon
    }
    
    init() {
        
    }
    
    func kelvinToCelciusToString(temp: Double) -> String {
        let answer = temp - 273.15
        let roundedAnswer = Int(answer)
        if roundedAnswer < 0 {
        return "\(roundedAnswer)°"
        } else {
            return " \(roundedAnswer)°"
        }
    }
    
    func kelvinToFaranheitToString(temp: Double ) -> String {
        let answer = temp * 9 / 5 - 459.67
        let roundedAnswer = Int(answer)
        
        return "\(roundedAnswer)° F"
    }
    
    func hectopascalsToKilopascalsToString(press: Double) -> String {
        let answer = Int(press / 10)
        
        return "\(answer) kPa"
    }
    
    func degreesToDirectionToString(deg: Double) -> String {
        var direction = ""
        
        if deg < 11.25 || deg > 348.75 {
            direction = "N"
        } else if deg < 33.75 {
            direction = "NNE"
        } else if deg < 56.25 {
            direction = "NE"
        } else if deg < 78.75 {
            direction = "ENE"
        } else if deg < 101.25 {
            direction = "E"
        } else if deg < 123.75 {
            direction = "ESE"
        } else if deg < 146.25 {
            direction = "SE"
        } else if deg < 168.75 {
            direction = "SSE"
        } else if deg < 191.25 {
            direction = "S"
        } else if deg < 213.75 {
            direction = "SSW"
        } else if deg < 236.25 {
            direction = "SW"
        } else if deg < 258.75 {
            direction = "WSW"
        } else if deg < 281.25 {
            direction = "W"
        } else if deg < 303.75 {
            direction = "WNW"
        } else if deg < 326.25 {
            direction = "NW"
        } else if deg < 348.75 {
            direction = "NNW"
        }
        
        return " \(deg)° \(direction)"
    }
    
}