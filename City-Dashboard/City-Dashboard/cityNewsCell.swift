//
//  cityNewsCell.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-21.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class cityNewsCell: UITableViewCell {

    @IBOutlet weak var imgCityNews: UIImageView!
    @IBOutlet weak var lblCityNews: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
