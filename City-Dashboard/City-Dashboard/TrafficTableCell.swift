//
//  TrafficTableCell.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-29.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class TrafficTableCell: UITableViewCell {

    @IBOutlet weak var vwTrafficCard: UIView!
    @IBOutlet weak var imgIncidentType: UIImageView!
    @IBOutlet weak var lblTrafficDescription: UILabel!
    @IBOutlet weak var lblDelayTime: UILabel!
    @IBOutlet weak var vwSeverity: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        circleView()
        colorBySeverity()
        configTrafficCard()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeTrafficCard:", name: "midViewOpen", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideCardShadow:", name: "resetViews", object: nil)
    }

   private func circleView() {
        vwSeverity.layer.cornerRadius = vwSeverity.bounds.height/2
        vwSeverity.clipsToBounds = true
    }
    
  private func colorBySeverity() {
       vwSeverity.backgroundColor = UIColor.redColor()
    }
    
    func configTrafficCard() {
        
       vwTrafficCard.layer.cornerRadius = 4
        vwTrafficCard.clipsToBounds = true
        vwTrafficCard.layer.borderColor = UIColor.whiteColor().CGColor
        vwTrafficCard.layer.borderWidth = 0.5
        
        let shadowPath = UIBezierPath(rect: self.vwTrafficCard.bounds)
        vwTrafficCard.layer.masksToBounds = false
        vwTrafficCard.layer.shadowColor = UIColor.blackColor().CGColor
        vwTrafficCard.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        vwTrafficCard.layer.shadowOpacity = 0
        vwTrafficCard.layer.shadowPath = shadowPath.CGPath  
    }
    
    
    func changeTrafficCard(notification:NSNotification) {
       // vwTrafficCard.layer.shadowOpacity = 0.5
    }
    func hideCardShadow(notification:NSNotification) {
      //  vwTrafficCard.layer.shadowOpacity = 0
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
