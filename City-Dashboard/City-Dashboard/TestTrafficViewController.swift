//
//  TestTrafficViewController.swift
//  City-Dashboard
//
//  Created by Alexander Besson on 2016-01-27.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class TestTrafficViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let mTest = Markets()
        mTest.downloadMarkets { () -> () in
            let ulLt = mTest.markets[0].boxUpperLeftLatitude
            let ulLn = mTest.markets[0].boxUpperLeftLongitude
            let lrLt = mTest.markets[0].boxLowerRightLatitude
            let lrLn = mTest.markets[0].boxLowerRightLongitude
            
            print(mTest.marketIndex["Denver"])
            
            let iTest = Incidents(ulLat: ulLt, ulLon: ulLn, lrLat: lrLt, lrLon: lrLn)
            iTest.downloadTrafficEvents({ () -> () in
                print(iTest.incidents[0].delayFromFreeFlow)
                print(iTest.incidents[0].delayFromTypical)
                print(iTest.incidents[0].severityIndex)
                print(iTest.incidents[0].typeIndex)
                print(iTest.incidents[0].impactingTraffic)
                
            })
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
