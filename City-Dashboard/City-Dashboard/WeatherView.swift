//
//  WeatherView.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-26.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit


class WeatherView: UIView {
    
    
    
    @IBOutlet weak var imgWeatherLogo: UIImageView!
    @IBOutlet weak var lblWeatherCategory: UILabel!
    @IBOutlet weak var logoRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblHumidityPercent: UILabel!
    @IBOutlet weak var lblWindSpeed: UILabel!
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblSunsetTime: UILabel!
    @IBOutlet weak var lblCloudPercent: UILabel!
    @IBOutlet weak var forecastView: UIView!
    
    @IBOutlet weak var lblWeatherDescription: UILabel!
    @IBOutlet weak var imgCurrentWeatherIcon: UIImageView!
    
    @IBOutlet weak var lblCurrentTempMin: UILabel!
    @IBOutlet weak var lblCurrentTempMax: UILabel!
    @IBOutlet weak var lblSunriseTime: UILabel!
    private var view: UIView!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        

    }
    
    private func xibSetup() {
        view = loadViewFromNib()
        
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "WeatherView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
  
    
    
    
       
  
    
}
