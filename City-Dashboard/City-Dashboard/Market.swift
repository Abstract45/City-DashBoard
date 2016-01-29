 //
//  Market.swift
//  Traffic API
//
//  Created by Alexander Besson on 2016-01-24.
//  Copyright © 2016 Alexander Besson. All rights reserved.
//

import Foundation

class Market {
    
    // private properties
    private var _city: String?
    private var _state: String?
    private var _latitude: Double?
    private var _longitude: Double?
    private var _boxUpperLeftLatitude: Double?
    private var _boxUpperLeftLongitude: Double?
    private var _boxLowerRightLatitude: Double?
    private var _boxLowerRightLongitude: Double?
    
    // computed properties with error handling
    
    // location
    
    var city: String {
        get {
            if _city != nil {
                return _city!
            } else {
                print("City property is nil in market.")
                return ""
            }
        }
        set(newValue) {
            _city = newValue
        }
    }
    
    var state: String {
        get {
            if _state != nil {
                return _state!
            } else {
                print("State property is nil in market.")
                return ""
            }
        }
        set(newValue) {
            _state = newValue
        }
    }
    
    var latitude: Double {
        get {
            if _latitude != nil {
                return _latitude!
            } else {
                print("Latitude property is nil in market.")
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
                print("Longitude value is nil in market.")
                return 0
            }
        }
        set(newValue) {
            _longitude = newValue
        }
    }
    
    // bounding box for map
    
    var boxUpperLeftLatitude: Double {
        get {
            if _boxUpperLeftLatitude != nil {
                return _boxUpperLeftLatitude!
            } else {
                print("BoxUpperLeftLatitude property is nil in market.")
                return 0
            }
        }
        set(newValue) {
            _boxUpperLeftLatitude = newValue
        }
    }
    
    var boxUpperLeftLongitude: Double {
        get {
            if _boxUpperLeftLongitude != nil {
                return _boxUpperLeftLongitude!
            } else {
                print("BoxUpperLeftLongitude property is nil in market.")
                return 0
            }
        }
        set(newValue) {
            _boxUpperLeftLongitude = newValue
        }
    }
    var boxLowerRightLatitude: Double {
        get {
            if _boxLowerRightLatitude != nil {
                return _boxLowerRightLatitude!
            } else {
                print("BoxLowerRightLatitude property is nil in market.")
                return 0
            }
        }
        set(newValue) {
            _boxLowerRightLatitude = newValue
        }
    }
    
    var boxLowerRightLongitude: Double {
        get {
            if _boxLowerRightLongitude != nil {
                return _boxLowerRightLongitude!
            } else {
                print("BoxLowerRightLongitude is nil in market.")
                return 0
            }
        }
        set(newValue) {
            _boxLowerRightLongitude = newValue
        }
    }
    
    // initializers
    
    init(city: String) {
        self._city = city
    }
    
    init(lat: Double, lon: Double) {
        _latitude = lat
        _longitude = lon
    }
    
    init() {
        
    }
 }