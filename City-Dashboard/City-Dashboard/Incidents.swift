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
    
    var upperLeftLatitude: Double?
    var upperLeftLongitude: Double?
    var lowerRightLatitude: Double?
    var lowerRightLongitude: Double?
    
    private var URL_BASE = "http://www.mapquestapi.com/traffic/v2/incidents?key=xJ45BUDAUC9X0QyNQVG5uv9gqHPr9yae&callback=handleIncidentsResponse&boundingBox="
    private var URL_END = "&inFormat=kvp&outFormat=json"
    private var urlString = ""
    
    internal typealias DownloadComplete = () -> ()
    
    init(ulLat: Double, ulLon: Double, lrLat: Double, lrLon: Double) {
        // These values provide the bounding box of the map for the API link.
        
        upperLeftLatitude = ulLat
        upperLeftLongitude = ulLon
        lowerRightLatitude = lrLat
        lowerRightLongitude = lrLon
        
        urlString = "http://www.mapquestapi.com/traffic/v2/incidents?key=xJ45BUDAUC9X0QyNQVG5uv9gqHPr9yae&callback=handleIncidentsResponse&boundingBox=43.937885,-80.00816,43.382116,-78.823744&filters=construction,incidents&inFormat=kvp&outFormat=ksp"
        
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
                                        tempIncident.severity = sever
                                    }
                                    
                                    if let type = inc["type"] as? Int {
                                        tempIncident.type = type
                                    }
                                    
                                    if let start = inc["startTime"] as? String {
                                        tempIncident.startTime = start
                                    }
                                    
                                    if let end = inc["endTime"] as? String {
                                        tempIncident.endTime = end
                                    }
                                    
                                    if let distance = inc["distance"] as? Double {
                                        tempIncident.distance = distance
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