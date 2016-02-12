//
//  TrafficCallOut.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-02-11.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class TrafficCallOut: UIView {

    @IBOutlet weak var vwSeverity: UIView!
    @IBOutlet weak var streetName: UILabel!
    
    @IBOutlet weak var incidentInfo: UILabel!
    
    
    override func awakeFromNib() {
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
