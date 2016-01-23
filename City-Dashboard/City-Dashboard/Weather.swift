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
    var city: String?
    var country: String?
    var latitude: Double?
    var longitude: Double?
    
    // weather info
    var temperature: Double?
    var temperatureMin: Double?
    var temperatureMax: Double?
    var pressure: Double?
    var humidity: Double?
    var windSpeed: Double?
    var windDirection: Double?
    var cloudCoverage: Double?
    
    // description of conditions
    var descriptionShort: String?
    var descriptionLong: String?
    
    init(city: String) {
        self.city = city
    }
    
    init(lat: Double, lon: Double) {
        latitude = lat
        longitude = lon
    }
    
    init() {
        
    }
    
    func testFunc() {
        print("Test func fired.")
    }
}