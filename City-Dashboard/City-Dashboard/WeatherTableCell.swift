//
//  WeatherTableCell.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-26.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class WeatherTableCell: UITableViewCell {

    @IBOutlet weak var weekday: UILabel!
    
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    @IBOutlet weak var imgDayIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        
    }
    
    

   
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
