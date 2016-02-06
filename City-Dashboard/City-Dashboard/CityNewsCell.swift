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
        configNewsCard()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeNewsCard:", name: "botViewOpen", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideCardShadow:", name: "resetViews", object: nil)
        vwNewsCard.enabled = false
    }
    
    
    func configNewsCard() {
        
            vwNewsCard.layer.cornerRadius = 5
            vwNewsCard.clipsToBounds = true
            let shadowPath = UIBezierPath(rect: self.vwNewsCard.bounds)
            vwNewsCard.layer.masksToBounds = false
            vwNewsCard.layer.shadowColor = UIColor.blackColor().CGColor
            vwNewsCard.layer.shadowOffset = CGSize(width: 0.0, height: 5)
            vwNewsCard.layer.shadowOpacity = 0
            vwNewsCard.layer.shadowPath = shadowPath.CGPath
        
    
    }
    func changeNewsCard(notification:NSNotification) {
        vwNewsCard.layer.shadowOpacity = 0.5
        vwNewsCard.enabled = true
    }
    func hideCardShadow(notification:NSNotification) {
        vwNewsCard.layer.shadowOpacity = 0
        vwNewsCard.enabled = false
       
    }
    
   
    @IBAction func newsSegue(sender: AnyObject) {
        
        
        NSUserDefaults.standardUserDefaults().setValue(_url, forKey: "currentURL")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        NSNotificationCenter.defaultCenter().postNotificationName("segueToWebView", object: nil)
        
    }
    
    
   

}
