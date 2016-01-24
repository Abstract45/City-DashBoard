//
//  CityNewsAlt.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-24.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class CityNewsAlt: UITableViewCell {

    @IBOutlet weak var lblHeadline: UILabel!
    @IBOutlet weak var timeAndCategory: UILabel!
    
    var time: String!
    var category: String!
    var headline: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
