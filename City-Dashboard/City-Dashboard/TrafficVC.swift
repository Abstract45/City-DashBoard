//
//  TrafficVC.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-02-01.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class TrafficVC: UIViewController {
    
    
    @IBOutlet var trafficMainView: TrafficMainView!
    private var midSize:CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        midSize = self.trafficMainView.frame.midX - 51.5
        trafficMainView.mapBtnView.addTarget(self, action: "segueToTrafficController", forControlEvents: .TouchUpInside)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "trafficMapSegue" {
            if !trafficMainView.incidentsArray.isEmpty {
                let destinationVC = segue.destinationViewController as! TrafficMapVC
                destinationVC.trafficIncidents = self.trafficMainView.incidentsArray
            }
        }
    }
    
    
}
