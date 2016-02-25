//
//  TrafficMapVC.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-02-09.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TrafficMapVC: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var trafficMapView: MKMapView!
    var trafficIncidents = [Incident]()
    
    let locationManager = CLLocationManager()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarHidden = true
        
      
        centerToLocation()

        addAnnotation(trafficIncidents)
    }
    
    func centerToLocation() {
   
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
           self.trafficMapView.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true)
        }
    }
    

    
    
    
    func addAnnotation(incidents:[Incident]) {
        
        for incident in incidents {
            
            let coordinate = CLLocationCoordinate2D(latitude: incident.latitude, longitude: incident.longitude)
            let title = incident.roadName
            let subtitle = incident.descriptionShort
            if let type = IncidentType(rawValue: incident.typeIndex) {
            
            let annotation = IncidentAnnotation(coordinate: coordinate, title: title, subtitle: subtitle, type: type)
               
                trafficMapView.addAnnotation(annotation)
            }
            
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = IncidentAnnotationView(annotation: annotation, reuseIdentifier: "Attraction")
        annotationView.canShowCallout = true
        return annotationView
    }
    
    
    @IBAction func closeMapView(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        UIApplication.sharedApplication().statusBarHidden = false
    }
    
}
