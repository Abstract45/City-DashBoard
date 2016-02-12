//
//  IncidentAnnotationView.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-02-12.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit
import MapKit

class IncidentAnnotationView: MKAnnotationView {
    
    
    
    // Called when drawing the AttractionAnnotationView
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // Required for MKAnnotationView
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        let incidentAnnotation = self.annotation as! IncidentAnnotation
        switch (incidentAnnotation.type) {
        case .Accident:
            image = UIImage(named: "Map")
        case .Congestion:
            image = UIImage(named: "Worker")
        case .Event:
            image = UIImage(named: "snow")
        default:
            image = UIImage(named: "Accident")
        }
    }
}


     