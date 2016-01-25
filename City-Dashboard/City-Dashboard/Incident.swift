//
//  Incident.swift
//  Traffic API
//
//  Created by Alexander Besson on 2016-01-24.
//  Copyright © 2016 Alexander Besson. All rights reserved.
//

import Foundation

class Incident {
    
    internal let incidentTypes = [1: "Construction", 2: "Event", 3: "Congestion", 4: "Accident/Incident"]
    internal let severityLevels = [0: "Traffic moving freely.", 1: "Minor slowdowns.", 2: "Some traffic congestion.", 3: "Heavy traffic.", 4: "Very heavy traffic."]
    
    // location of incident
    var latitude: Double?
    var longitude: Double?
    
    var type: Int?
    var severity: Int?
    var impactingTraffic: Bool?
    var startTime: String?
    var endTime: String?
    
    // String for basic description: position1 + crossRoads1 + position2 + crossRoads2
    var position1: String?
    var crossRoads1: String?
    var position2: String?
    var crossRoads2: String?
    var direction: String?
    var distance: Double?
    
    var fromLocation: String?
    var toLocation: String?
    var roadName: String?
    
    var descriptionShort: String?
    var descriptionLong: String?
    
    var delayFromTypical: Double?
    var delayFromFreeFlow: Double?
    
    init() {
        
    }
}