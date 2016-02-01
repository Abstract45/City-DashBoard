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
    
    private var view: UIView!
    
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
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
           trafficTableView.registerNib(UINib.init(nibName: "TrafficTableCell", bundle: nil), forCellReuseIdentifier: "traffic")
        
        let cell = trafficTableView.dequeueReusableCellWithIdentifier("traffic") as! TrafficTableCell
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }
    
   
    
    
    

}
