//
//  TrafficMainView.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-29.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

 class TrafficMainView: UIView, UITableViewDelegate, UITableViewDataSource {
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
        populateTrafficCells()
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
        
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
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
        

        cell.lblTrafficDescription.text = incidentsArray[indexPath.row].descriptionShort ?? ""
        cell.lblDelayTime.text = String(incidentsArray[indexPath.row].delayFromFreeFlow) ?? ""
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }
    
   
    @IBAction func btnMapFlip(sender: AnyObject) {
   
    }
    
    
    func populateTrafficCells() -> [Incident] {
        
       
        
        let market = Markets()
        
        market.downloadMarkets { () -> () in
            
            let upperLat = market.markets[market.marketIndex["Toronto"]!].boxUpperLeftLatitude
            let upperLon = market.markets[market.marketIndex["Toronto"]!].boxUpperLeftLongitude
            let lowerLat = market.markets[market.marketIndex["Toronto"]!].boxLowerRightLatitude
            let lowerLon = market.markets[market.marketIndex["Toronto"]!].boxLowerRightLongitude
            
            let incidents = Incidents(ulLat: upperLat, ulLon: upperLon, lrLat: lowerLat, lrLon: lowerLon)
            
            incidents.downloadTrafficEvents({ () -> () in
                
                self.incidentsArray = incidents.incidents
                self.trafficTableView.reloadData()
            })
            
        }
        
        
        return incidentsArray
        
    }

}
