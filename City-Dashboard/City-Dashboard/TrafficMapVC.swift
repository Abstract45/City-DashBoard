//
//  TrafficMapVC.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-02-09.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit
import MapKit

class TrafficMapVC: UIViewController {

    @IBOutlet weak var trafficMapView: MKMapView!
    var trafficIncidents = [Incident]()
    let regionRadius: CLLocationDistance = 1000
     let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarHidden = true
        centerMapOnLocation(initialLocation)
   
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        trafficMapView.setRegion(coordinateRegion, animated: true)
    }
    @IBAction func closeMapView(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        UIApplication.sharedApplication().statusBarHidden = false
    }

}
