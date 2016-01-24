//
//  CityNewsMain.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-24.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class CityNewsMain: UITableViewCell {

    @IBOutlet weak var timeCategory: UILabel!
    @IBOutlet weak var headlines: UILabel!
    @IBOutlet weak var imgCityNews: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
