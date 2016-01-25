//
//  Markets.swift
//  Traffic API
//
//  Created by Alexander Besson on 2016-01-24.
//  Copyright © 2016 Alexander Besson. All rights reserved.
//

import Foundation

class Markets {
    
    var markets = [Market]()
    var marketIndex = [String: Int]()
    
    private var KEY_API = "xJ45BUDAUC9X0QyNQVG5uv9gqHPr9yae"
    private let urlString = "http://www.mapquestapi.com/traffic/v2/markets?key=xJ45BUDAUC9X0QyNQVG5uv9gqHPr9yae"
    
    internal typealias DownloadComplete = () -> ()
    
    init() {
        
    }
    
    func downloadMarkets(competion: DownloadComplete) {
                
        let url = NSURL(string: urlString)
        
        _ = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                        
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                do {
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    
                    if let marketsDict = json as? Dictionary<String, AnyObject> {
                        
                        if let markets = marketsDict["markets"] as? Array<AnyObject> {
                            
                            var counter = -1
                            
                            for m in markets {
                                let tempMarket = Market()
                                counter++
                                
                                if let mark = m as? Dictionary<String, AnyObject> {
                                    
                                    if let cit = mark["city"] as? String {
                                        self.marketIndex[cit] = counter
                                        tempMarket.city = cit
                                    }
                                    
                                    if let stt = mark["state"] as? String {
                                        tempMarket.state = stt
                                    }
                                    
                                    if let lt = mark["lat"] as? Double {
                                        tempMarket.latitude = lt
                                    }
                                    
                                    if let ln = mark["lng"] as? Double {
                                        tempMarket.longitude = ln
                                    }
                                    
                                    if let bBox = mark["boundingBox"] as? Dictionary<String, AnyObject> {
                                        
                                        if let ul = bBox["ul"] as? Dictionary<String, AnyObject> {
                                            
                                            if let lat = ul["lat"] as? Double {
                                                tempMarket.boxUpperLeftLatitude = lat
                                            }
                                            
                                            if let lng = ul["lng"] as? Double {
                                                tempMarket.boxUpperLeftLongitude = lng
                                            }
                                        }
                                        
                                        if let lr = bBox["lr"] as? Dictionary<String, AnyObject> {
                                            
                                            if let lat = lr["lat"] as? Double {
                                                tempMarket.boxLowerRightLatitude = lat
                                            }
                                            
                                            if let lng = lr["lng"] as? Double {
                                                tempMarket.boxLowerRightLongitude = lng
                                            }
                                        }
                                    }
                                    
                                }
                                
                                self.markets.append(tempMarket)
                            }
                            
                        }
                    }
                    
                } catch {
                    
                    print("Could not serialize json for traffic markets.")
                }
                
                competion()

            })
            
        }).resume()
    }
    
}