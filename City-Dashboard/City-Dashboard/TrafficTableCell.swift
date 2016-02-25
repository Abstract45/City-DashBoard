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
        vwTrafficCard.layer.cornerRadius = 3
        vwTrafficCard.clipsToBounds = true
        circleView()
        colorBySeverity()
        
    }

    private func circleView() {
        vwSeverity.layer.cornerRadius = vwSeverity.bounds.height/2
        vwSeverity.clipsToBounds = true
    }
    
    private func colorBySeverity() {
       vwSeverity.backgroundColor = UIColor.redColor()
    
        
    }
    

}
