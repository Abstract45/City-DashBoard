//
//  CityNewsMain.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-29.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

 class CityNewsMain: UIView, UITableViewDataSource, UITableViewDelegate {
 private var view: UIView!
 
    
    @IBOutlet weak var logoRightConstraint: NSLayoutConstraint!

    @IBOutlet weak var lblDailyHeadlines: UILabel!
    
    @IBOutlet weak var newsTableView: UITableView!
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
        let nib = UINib(nibName: "CityNewsMain", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        newsTableView.registerNib(UINib.init(nibName: "CityNewsCell", bundle: nil), forCellReuseIdentifier:"news")
        let cell = newsTableView.dequeueReusableCellWithIdentifier("news") as! CityNewsCell
       
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 91
    }
    
    
    
    

}
