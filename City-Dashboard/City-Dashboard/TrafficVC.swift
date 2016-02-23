//
//  TrafficVC.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-02-01.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TrafficVC: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var locManager = CLLocationManager()
    @IBOutlet weak var trafficTableView: UITableView!
    @IBOutlet var trafficMainView: TrafficMainView!
    private var midSize:CGFloat = 0
    var incidentsArray = [Incident()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        midSize = self.view.bounds.midX - 51.5
        trafficMainView.mapBtnView.addTarget(self, action: "segueToTrafficController", forControlEvents: .TouchUpInside)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureLocationManager()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeTrafficXib:", name: "changeMiddleView", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetTrafficXib:", name: "resetViews", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "midOpen:", name: "midViewOpen", object: nil)
    }
    
    
    func segueToTrafficController() {
        self.performSegueWithIdentifier("trafficMapSegue", sender: self)
    }
    
    func changeTrafficXib(notification:NSNotification) {
        UIView.animateWithDuration(1) { () -> Void in
            self.trafficMainView.logoRightConstraint.constant = self.midSize
             self.trafficMainView.lblCurrentIncidents.alpha = 0
                self.view.layoutIfNeeded()
        }
    }
    
    func midOpen(notification:NSNotification) {
        UIView.animateWithDuration(1) { () -> Void in
            self.trafficMainView.mapBtnView.alpha = 1
            self.trafficMainView.lblTitleDelay.alpha = 1
            self.trafficMainView.mapBtnRightConstraint.constant = 10
            self.trafficMainView.logoRightConstraint.constant = 90
            
            self.trafficMainView.imgLogo.alpha = 0
            self.trafficMainView.lblTraffic.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func resetTrafficXib(notification:NSNotification) {
        UIView.animateWithDuration(1) { () -> Void in
            self.trafficMainView.logoRightConstraint.constant = 22
            self.trafficMainView.lblCurrentIncidents.alpha = 1
            self.trafficMainView.lblTitleDelay.alpha = 0
            self.trafficMainView.imgLogo.alpha = 1
            self.trafficMainView.mapBtnRightConstraint.constant = -77
            self.trafficMainView.lblTraffic.alpha = 1
            self.trafficMainView.mapBtnView.alpha = 0
            self.view.layoutIfNeeded()
        }
        
    }
    
    // Location functions
    
    func configureLocationManager() {
        locManager = CLLocationManager()
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        locManager.requestLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locManager.stopUpdatingLocation()
        
        let userLocation = locations[0]
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            
            if error != nil {
                print("Error: " + (error?.localizedDescription)!)
                
            } else {
                
                if placemarks != nil {
                    let p = CLPlacemark(placemark: placemarks![0])
                    
                    if p.subAdministrativeArea != nil {
                        
                    self.populateTrafficCells(p.subAdministrativeArea!, lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude)
                    }
                }
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "trafficMapSegue" {
            if !self.incidentsArray.isEmpty {
                let destinationVC = segue.destinationViewController as! TrafficMapVC
                destinationVC.trafficIncidents = self.incidentsArray
            }
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incidentsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        trafficTableView.registerNib(UINib.init(nibName: "TrafficTableCell", bundle: nil), forCellReuseIdentifier: "traffic")
        
        let cell = trafficTableView.dequeueReusableCellWithIdentifier("traffic") as! TrafficTableCell
        
        
        cell.lblTrafficDescription.text = incidentsArray[indexPath.row].descriptionShort
        cell.lblDelayTime.text = "\(incidentsArray[indexPath.row].delayFromFreeFlow) mins"
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }
    
    
    
    // Function that populates Traffic TableView Cells
    
    func populateTrafficCells(city: String, lat: Double, lon: Double) -> [Incident] {
        
        let market = Markets()
        
        market.downloadMarkets { () -> () in
            
            if market.marketIndex[city] != nil {
                
                let upperLat = market.markets[market.marketIndex[city]!].boxUpperLeftLatitude
                let upperLon = market.markets[market.marketIndex[city]!].boxUpperLeftLongitude
                let lowerLat = market.markets[market.marketIndex[city]!].boxLowerRightLatitude
                let lowerLon = market.markets[market.marketIndex[city]!].boxLowerRightLongitude
                
                let incidents = Incidents(ulLat: upperLat, ulLon: upperLon, lrLat: lowerLat, lrLon: lowerLon)
                
                incidents.downloadTrafficEvents({ () -> () in
                    
                    self.incidentsArray = incidents.incidents
                    self.trafficTableView.reloadData()
                })
                
            } else {
                print("else hit")
                let upperLat = lat - 1
                let upperLon = lon + 1
                let lowerLat = lat + 1
                let lowerLon = lon - 1
                
                let incidents = Incidents(ulLat: upperLat, ulLon: upperLon, lrLat: lowerLat, lrLon: lowerLon)
                
                incidents.downloadTrafficEvents({ () -> () in
                    
                    self.incidentsArray = incidents.incidents
                    self.trafficTableView.reloadData()
                })
            }
            
        }
        
        return incidentsArray
        
    }
    

    
}
