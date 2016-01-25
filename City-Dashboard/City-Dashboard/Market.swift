 //
//  Market.swift
//  Traffic API
//
//  Created by Alexander Besson on 2016-01-24.
//  Copyright © 2016 Alexander Besson. All rights reserved.
//

import Foundation

class Market {
    
    // location
    var city: String?
    var state: String?
    var latitude: Double?
    var longitude: Double?
    
    // bounding box for map
    var boxUpperLeftLatitude: Double?
    var boxUpperLeftLongitude: Double?
    var boxLowerRightLatitude: Double?
    var boxLowerRightLongitude: Double?
    
    init(city: String) {
        self.city = city
    }
    
    init(lat: Double, lon: Double) {
        latitude = lat
        longitude = lon
    }
    
    init() {
        
    }
 }