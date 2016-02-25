//
//  TrafficMainView.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-29.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit
import CoreLocation

 class TrafficMainView: UIView, UITableViewDelegate, UITableViewDataSource {
    
   
    
    @IBOutlet weak var mapBtnRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var trafficTableView: UITableView!
    @IBOutlet weak var logoRightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lblTitleDelay: UILabel!
    @IBOutlet weak var lblTraffic: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var mapBtnView: UIButton!
    @IBOutlet weak var lblCurrentIncidents: UILabel!
    
    private var view: UIView!
    
    var incidentsArray = [Incident()]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        xibSetup()
    }
    private func xibSetup() {
        view = loadViewFromNib()
        view.frame = UIScreen.mainScreen().bounds
        addSubview(view)
        
    }
    
    
    
    private func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib.init(nibName: "TrafficMainView", bundle: bundle)
         view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
       
        return view
        
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
