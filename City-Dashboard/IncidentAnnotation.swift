//
//  IncidentAnnotation.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-02-12.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//



import UIKit
import MapKit

enum IncidentType: Int {
    case Construction = 1
    case Event
    case Congestion
    case Accident
}

class IncidentAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var type: IncidentType
    var subtitle:String?
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, type: IncidentType) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.type = type
    }
}