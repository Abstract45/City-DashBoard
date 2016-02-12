//
//  CityNewsCell.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-24.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit




class CityNewsCell: UITableViewCell {

    
    @IBOutlet weak var vwNewsCard: UIButton!
    
    @IBOutlet weak var timeCategory: UILabel!
    @IBOutlet weak var headlines: UILabel!
    @IBOutlet weak var imgCityNews: UIImageView!
    
    private var _url: String = ""
   
    var url: String {
        get {
            return ""
        }
        set(newValue) {
           _url = newValue
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        vwNewsCard.layer.cornerRadius = 5
        vwNewsCard.clipsToBounds = true
       
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeNewsCard:", name: "botViewOpen", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideCardShadow:", name: "resetViews", object: nil)
        vwNewsCard.enabled = false
    }
    
    
  
    func changeNewsCard(notification:NSNotification) {
        
        vwNewsCard.enabled = true
    }
    func hideCardShadow(notification:NSNotification) {
        
        vwNewsCard.enabled = false
       
    }
    
   
    @IBAction func newsSegue(sender: AnyObject) {
        
        
        NSUserDefaults.standardUserDefaults().setValue(_url, forKey: "currentURL")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        NSNotificationCenter.defaultCenter().postNotificationName("segueToWebView", object: nil)
        
    }
    
    
   

}
