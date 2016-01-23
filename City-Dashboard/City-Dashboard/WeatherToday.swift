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
    var sunrise: Double?
    var sunset: Double?
    
    override init(city: String) {
        super.init(city: city)
    }
    
    override init(lat: Double, lon: Double) {
        super.init(lat: lat, lon: lon)
    }
}