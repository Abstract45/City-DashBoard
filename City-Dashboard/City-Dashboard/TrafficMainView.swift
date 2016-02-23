//
//  TrafficMainView.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-29.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit
import CoreLocation

 class TrafficMainView: UIView {
    
   
    
    @IBOutlet weak var mapBtnRightConstraint: NSLayoutConstraint!
 
    @IBOutlet weak var logoRightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lblTitleDelay: UILabel!
    @IBOutlet weak var lblTraffic: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var mapBtnView: UIButton!
    @IBOutlet weak var lblCurrentIncidents: UILabel!
    
    private var view: UIView!
    
    
    
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
    
       

}
