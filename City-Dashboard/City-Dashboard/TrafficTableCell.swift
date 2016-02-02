//
//  TrafficTableCell.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-29.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class TrafficTableCell: UITableViewCell {

    @IBOutlet weak var severityView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        circleView()
    }

   private func circleView() {
        severityView.layer.cornerRadius = severityView.bounds.height/2
        severityView.clipsToBounds = true
    }
    
  private func colorBySeverity() {
        
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
