//
//  Incident.swift
//  Traffic API
//
//  Created by Alexander Besson on 2016-01-24.
//  Copyright © 2016 Alexander Besson. All rights reserved.
//

import Foundation

class Incident {
    
    private let incidentTypes = [1: "Construction", 2: "Event", 3: "Congestion", 4: "Accident/Incident"]
    private let severityLevels = [0: "Traffic moving freely.", 1: "Minor slowdowns.", 2: "Some traffic congestion.", 3: "Heavy traffic.", 4: "Very heavy traffic."]
    private let errorMessage = "value is nil in incident object."
    
    private var _latitude: Double?
    private var _longitude: Double?
    
    // location of incident
    var latitude: Double {
        get {
            if _latitude != nil {
                return _latitude!
            } else {
                print("Latitude: " + errorMessage)
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
                print("Longitude: " + errorMessage)
                return 0
            }
        }
        set(newValue) {
            _longitude = newValue
        }
    }
    
    // effect on traffic
    private var _typeIndex: Int?
    private var _severityIndex: Int?
    private var _type: String?
    private var _severity: String?
    private var _impactingTraffic: Bool?
    
    var typeIndex: Int {
        get {
            if _typeIndex != nil {
                return _typeIndex!
            } else {
                print("TypeIndex: " + errorMessage)
                return -1
            }
        }
        set(newValue) {
            _typeIndex = newValue
            _type = incidentTypes[newValue]
        }
    }
    
    var severityIndex: Int {
        get {
            if _severityIndex != nil {
                return _severityIndex!
            } else {
                print("SeverityIndex: " + errorMessage)
                return -1
            }
        }
        set(newValue) {
            _severityIndex = newValue
            _severity = severityLevels[newValue]
        }
    }
    
    var type: String {
        if _type != nil {
            return _type!
        } else {
            print("Type: " + errorMessage)
            return ""
        }
    }
    
    var severity: String {
        if _severity != nil {
            return _severity!
        } else {
            print("Severity: " + errorMessage)
            return ""
        }
    }
    
    var impactingTraffic: Bool {
        get {
            if _impactingTraffic != nil {
                return _impactingTraffic!
            } else {
                print("ImpactingTraffic: " + errorMessage)
                return false
            }
        }
        set(newValue) {
            _impactingTraffic = newValue
        }
    }
    
    // start and end time of traffic event
    private var _startTime: String?
    private var _endTime: String?
    
    var startTime: String {
        get {
            if _startTime != nil {
                return _startTime!
            } else {
                print("StartTime: " + errorMessage)
                return ""
            }
        }
        set(newValue) {
            _startTime = newValue
        }
    }
    
    var endTime: String {
        get {
            if _endTime != nil {
                return _endTime!
            } else {
                print("EndTime: " + errorMessage)
                return ""
            }
        }
        set(newValue) {
            _endTime = newValue
        }
    }
    
    // String for basic description: position1 + crossRoads1 + position2 + crossRoads2
    private var _position1: String?
    private var _crossRoads1: String?
    private var _position2: String?
    private var _crossRoads2: String?
    private var _direction: String?
    private var _distance: Double?
    
    var position1: String {
        get {
            if _position1 != nil {
                return _position1!
            } else {
                print("Position1: " + errorMessage)
                return ""
            }
        }
        set(newValue) {
            _position1 = newValue
        }
    }
    
    var crossRoads1: String {
        get {
            if _crossRoads1 != nil {
                return _crossRoads1!
            } else {
                print("CrossRoads1: " + errorMessage)
                return ""
            }
        }
        set(newValue) {
            _crossRoads1 = newValue
        }
    }
    
    var position2: String {
        get {
            if _position2 != nil {
                return _position2!
            } else {
                print("Position2: " + errorMessage)
                return ""
            }
        }
        set(newValue) {
            _position2 = newValue
        }
    }
    
    var crossRoads2: String {
        get {
            if _crossRoads2 != nil {
                return _crossRoads2!
            } else {
                print("CrossRoads2: " + errorMessage)
                return ""
            }
        }
        set(newValue) {
            _crossRoads2 = newValue
        }
    }
    
    var direction: String {
        get {
            if _direction != nil {
                return _direction!
            } else {
                print("Direction: " + errorMessage)
                return ""
            }
        }
        set(newValue) {
            _direction = newValue
        }
    }
    
    var distanceDouble: Double {
        get {
            if _distance != nil {
                return _distance!
            } else {
                print("DistanceDouble: " + errorMessage + " Use distance variable insted as it returns a string.")
                return 0
            }
        }
        set(newValue) {
            _distance = newValue
        }
    }
    
    var distance: String {
        if _distance != nil {
            return "\(_distance)"
        } else {
            print("Distance: " + errorMessage)
            return ""
        }
    }
    
    // further location details
    private var _fromLocation: String?
    private var _toLocation: String?
    private var _roadName: String?
    
    var fromLocation: String {
        get {
            if _fromLocation != nil {
                return _fromLocation!
            } else {
                print("FromLocation: " + errorMessage)
                return ""
            }
        }
        set(newValue) {
            _fromLocation = newValue
        }
    }
    
    var toLocation: String {
        get {
            if _toLocation != nil {
                return _toLocation!
            } else {
                print("ToLocation: " + errorMessage)
                return ""
            }
        }
        set(newValue) {
            _toLocation = newValue
        }
    }
    var roadName: String {
        get {
            if _roadName != nil {
                return _roadName!
            } else {
                print("RoadName: " + errorMessage)
                return ""
            }
        }
        set(newValue) {
            _roadName = newValue
        }
    }
    
    // description of incident
    private var _descriptionShort: String?
    private var _descriptionLong: String?
    
    var descriptionShort: String {
        get {
            if _descriptionShort != nil {
                return _descriptionShort!
            } else {
                print("DescriptionShort: " + errorMessage)
                return ""
            }
        }
        set(newValue) {
            _descriptionShort = newValue
        }
    }
    
    var descriptionLong: String {
        get {
            if _descriptionShort != nil {
                return _descriptionShort!
            } else {
                print("DescriptionShort: " + errorMessage)
                return ""
            }
        }
        set(newValue) {
            _descriptionShort = newValue
        }
    }
    
    // delay relative to normal and optimal traffic levels
    private var _delayFromTypical: Double?
    private var _delayFromFreeFlow: Double?
    
    var delayFromTypical: Double {
        get {
            if _delayFromTypical != nil {
                return _delayFromTypical!
            } else {
                print("DelayFromTypical: " + errorMessage)
                return 0
            }
        }
        set(newValue) {
            _delayFromTypical = newValue
        }
    }
    var delayFromFreeFlow: Double {
        get {
            if _delayFromFreeFlow != nil {
                return _delayFromFreeFlow!
            } else {
                print("DelayFromFreeFlow: " + errorMessage)
                return 0
            }
        }
        set(newValue) {
            _delayFromFreeFlow = newValue
        }
    }
    
    init() {
        
    }
}