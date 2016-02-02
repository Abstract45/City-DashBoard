//
//  TestTrafficViewController.swift
//  City-Dashboard
//
//  Created by Alexander Besson on 2016-01-27.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit
import CoreLocation

class TestTrafficViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.requestLocation()
        
        let mTest = Markets()
        mTest.downloadMarkets { () -> () in
            let ulLt = mTest.markets[0].boxUpperLeftLatitude
            let ulLn = mTest.markets[0].boxUpperLeftLongitude
            let lrLt = mTest.markets[0].boxLowerRightLatitude
            let lrLn = mTest.markets[0].boxLowerRightLongitude
            
            let iTest = Incidents(ulLat: ulLt, ulLon: ulLn, lrLat: lrLt, lrLon: lrLn)
            iTest.downloadTrafficEvents({ () -> () in
                
            })
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationManager.stopUpdatingLocation()
        
        let upLat = locations[0].coordinate.latitude + 1
        let upLon = locations[0].coordinate.longitude - 1
        let lowLat = locations[0].coordinate.latitude - 1
        let lowLon = locations[0].coordinate.longitude + 1
        
        let iTest = Incidents(ulLat: upLat, ulLon: upLon, lrLat: lowLat, lrLon: lowLon)
        
        iTest.downloadTrafficEvents { () -> () in
            print(iTest.incidents[0].roadName)
            print(iTest.incidents.count)
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
