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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeTrafficXib:", name: "changeMiddleView", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetTrafficXib:", name: "resetViews", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "midOpen:", name: "midViewOpen", object: nil)
       
           
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
            self.trafficMainView.imgLogo.alpha = 0
            self.trafficMainView.lblTraffic.alpha = 0
        }
    }
    
    func resetTrafficXib(notification:NSNotification) {
        UIView.animateWithDuration(1) { () -> Void in
            self.trafficMainView.logoRightConstraint.constant = 22
            self.trafficMainView.lblCurrentIncidents.alpha = 1
            self.trafficMainView.lblTitleDelay.alpha = 0
            self.trafficMainView.imgLogo.alpha = 1
            self.trafficMainView.lblTraffic.alpha = 1
            self.trafficMainView.mapBtnView.alpha = 0
            self.view.layoutIfNeeded()
        }
        
    }
    
    
}
