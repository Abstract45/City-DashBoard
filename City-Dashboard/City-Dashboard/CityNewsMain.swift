//
//  CityNewsMain.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-29.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class CityNewsMain: UIView {
    
    private var view: UIView!
    
    
    
    @IBOutlet weak var logoRightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lblDailyHeadlines: UILabel!
    

    
    @IBOutlet weak var lblNewsCategory: UILabel!
    @IBOutlet weak var imgNewsLogo: UIImageView!
    @IBOutlet weak var vwTop: UIView!
   
    
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
        let nib = UINib(nibName: "CityNewsMain", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
   
    
   
    
    
}
