//
//  Incidents.swift
//  Traffic API
//
//  Created by Alexander Besson on 2016-01-25.
//  Copyright © 2016 Alexander Besson. All rights reserved.
//

import Foundation

class Incidents {
    
    var incidents = [Incident]()
    
    private var _upperLeftLatitude: Double?
    private var _upperLeftLongitude: Double?
    private var _lowerRightLatitude: Double?
    private var _lowerRightLongitude: Double?
    
    var upperLeftLatitude: Double {
        if _upperLeftLatitude != nil {
            return _upperLeftLatitude!
        } else {
            print("UpperLeftLatitude: " + errorMessage)
            return 0
        }
    }
    
    var upperLeftLongitude: Double {
        if _upperLeftLongitude != nil {
            return _upperLeftLongitude!
        } else {
            print("UpperLeftLongitude: " + errorMessage)
            return 0
        }
    }
    
    var lowerRightLatitude: Double {
        if _lowerRightLatitude != nil {
            return _lowerRightLatitude!
        } else {
            print("LowerRightLatitude: " + errorMessage)
            return 0
        }
    }
    
    var lowerRightLongitude: Double {
        if _lowerRightLongitude != nil {
            return _lowerRightLongitude!
        } else {
            print("LowerRightLongitude: " + errorMessage)
            return 0
        }
    }
    
    private let errorMessage = "value is nill in Incidents object."
    private let URL_BASE = "http://www.mapquestapi.com/traffic/v2/incidents?key=xJ45BUDAUC9X0QyNQVG5uv9gqHPr9yae&callback=handleIncidentsResponse&boundingBox="
    private let URL_END = "&inFormat=kvp&outFormat=json"
    private var urlString = ""
    
    internal typealias DownloadComplete = () -> ()
    
    init(ulLat: Double, ulLon: Double, lrLat: Double, lrLon: Double) {
        // These values provide the bounding box of the map for the API link.
        
        _upperLeftLatitude = ulLat
        _upperLeftLongitude = ulLon
        _lowerRightLatitude = lrLat
        _lowerRightLongitude = lrLon
        
        urlString = "http://www.mapquestapi.com/traffic/v2/incidents?key=xJ45BUDAUC9X0QyNQVG5uv9gqHPr9yae&callback=handleIncidentsResponse&boundingBox=43.849529,-79.657187,43.452068,-79.107870&filters=construction,incidents&inFormat=kvp&outFormat=ksp"
        
//            + "\(upperLeftLatitude)," + "\(upperLeftLongitude)," + "\(lowerRightLatitude)," + "\(lowerRightLongitude)," + URL_END
        
    }
    
    func downloadTrafficEvents(completion: DownloadComplete) {
        
        let url = NSURL(string: urlString)
        
        let _ = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
                do {
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    
                    if let incidentsDict = json as? Dictionary<String, AnyObject> {

                        if let incidents = incidentsDict["incidents"] as? Array<AnyObject> {
                            
                            for i in incidents {
                                
                                let tempIncident = Incident()
                                
                                if let inc = i as? Dictionary<String,AnyObject> {
                                    
                                    if let paramDesc = inc["parameterizedDescription"] as? Dictionary<String, AnyObject> {
                                        
                                        if let pos1 = paramDesc["position1"] as? String {
                                            tempIncident.position1 = pos1
                                        }
                                        
                                        if let pos2 = paramDesc["position2"] as? String {
                                            tempIncident.position2 = pos2
                                        }
                                        
                                        if let cross1 = paramDesc["crossRoad1"] as? String {
                                            tempIncident.crossRoads1 = cross1
                                        }
                                        
                                        if let cross2 = paramDesc["crossRoad2"] as? String {
                                            tempIncident.crossRoads2 = cross2
                                        }
                                        
                                        if let direct = paramDesc["direction"] as? String {
                                            tempIncident.direction = direct
                                        }
                                        
                                        if let fromLoc = paramDesc["fromLocation"] as? String {
                                            tempIncident.fromLocation = fromLoc
                                        }
                                        
                                        if let toLoc = paramDesc["toLocation"] as? String {
                                            tempIncident.toLocation = toLoc
                                        }
                                        
                                        if let rdName = paramDesc["roadName"] as? String {
                                            tempIncident.roadName = rdName
                                        }
                                    }
                                    
                                    if let delFromFF = inc["delayFromFreeFlow"] as? Double {
                                        tempIncident.delayFromFreeFlow = delFromFF
                                    }
                                    
                                    if let delFromTyp = inc["delayFromTypical"] as? Double {
                                        tempIncident.delayFromTypical = delFromTyp
                                    }
                                    
                                    if let shortDesc = inc["shortDesc"] as? String {
                                        tempIncident.descriptionShort = shortDesc
                                    }
                                    
                                    if let fullDesc = inc["fullDesc"] as? String {
                                        tempIncident.descriptionLong = fullDesc
                                    }
                                    
                                    if let sever = inc["severity"] as? Int {
                                        tempIncident.severityIndex = sever
                                    }
                                    
                                    if let type = inc["type"] as? Int {
                                        tempIncident.typeIndex = type
                                    }
                                    
                                    if let start = inc["startTime"] as? String {
                                        tempIncident.startTime = start
                                    }
                                    
                                    if let end = inc["endTime"] as? String {
                                        tempIncident.endTime = end
                                    }
                                    
                                    if let distance = inc["distance"] as? Double {
                                        tempIncident.distanceDouble = distance
                                    }
                                    
                                    if let impact = inc["impacting"] as? Bool {
                                        tempIncident.impactingTraffic = impact
                                    }
                                    
                                    if let lat = inc["lat"] as? Double {
                                        tempIncident.latitude = lat
                                    }
                                    
                                    if let lon = inc["lng"] as? Double {
                                        tempIncident.longitude = lon
                                    }
                                    
                                    self.incidents.append(tempIncident)
                                }
                                
                            }
                        }
                    }
                    
                } catch {
                    print("Could not serialize JSON for traffic incidents link.")
                }
                
                completion()
                
            })
            
        }).resume()
    }
    
}