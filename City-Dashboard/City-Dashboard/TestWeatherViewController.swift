//
//  TestWeatherViewController.swift
//  City-Dashboard
//
//  Created by Alexander Besson on 2016-01-29.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class TestWeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let wTest = WeatherForecast(city: "Toronto")
        wTest.downloadTodaysWeather { () -> () in
            
        }
        
        wTest.downloadWeeklyForecast { () -> () in
            print(wTest.weatherNext[0].temperatureNight)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
