//
//  News.swift
//  News API
//
//  Created by Alexander Besson on 2016-02-02.
//  Copyright © 2016 Alexander Besson. All rights reserved.
//

import Foundation

class News {
    
    var news = [NewsItem]()
    
    typealias DownloadComplete = () -> ()
    private var KEY_API = "3ba12a165e9410d1b2dbe69ec21e26f6:17:74262608"
    
    init() {
        
    }
    
    func downloadNews(completion: DownloadComplete) {
        
        let urlString = "http://api.nytimes.com/svc/topstories/v1/home.json?api-key=3ba12a165e9410d1b2dbe69ec21e26f6:17:74262608"
        
        let url = NSURL(string: urlString)
        
        let _ = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                do {
                    guard let data = data else {
                        return
                    }
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                    
                    if let newsDict = json as? Dictionary<String, AnyObject> {
                        
                        if let results = newsDict["results"] as? Array<AnyObject> {
                            
                            for result in results {
                                
                                let newsItem = NewsItem()
                                
                                if let r = result as? Dictionary<String, AnyObject> {
                                    
                                    if let ttl = r["title"] as? String {
                                        newsItem.title = ttl
                                    }
                                    
                                    if let sec = r["section"] as? String {
                                        newsItem.section = sec
                                    }
                                    
                                    if let subSec = r["subsection"] as? String {
                                        newsItem.subSection = subSec
                                    }
                                    
                                    if let abs = r["abstract"] as? String {
                                        newsItem.abstract = abs
                                    }
                                    
                                    if let urlStr = r["url"] as? String {
                                        newsItem.url = urlStr
                                    }
                                    
                                    if let byln = r["byline"] as? String {
                                        newsItem.author = byln
                                    }
                                    
                                    if let uDate = r["updated_date"] as? String {
                                        newsItem.dateUpdated = uDate
                                    }
                                    
                                    if let cDate = r["created_date"] as? String {
                                        newsItem.dateCreated = cDate
                                    }
                                    
                                    if let pDate = r["published_date"] as? String {
                                        newsItem.datePublished = pDate
                                    }
                                    
                                    if let kik = r["kicker"] as? String {
                                        newsItem.kicker = kik
                                    }
                                    
                                    if let desF = r["des_facet"] as? Array<String> {
                                        
                                        newsItem.facetDescription.removeAll()
                                        
                                        for df in desF {
                                            
                                            newsItem.facetDescription.append(df)
                                        }
                                    }
                                    
                                    if let orgF = r["org_facet"] as? Array<String> {
                                        
                                        newsItem.facetOrganization.removeAll()
                                        
                                        for of in orgF {
                                            
                                            newsItem.facetOrganization.append(of)
                                        }
                                    }
                                    
                                    if let perF = r["per_facet"] as? Array<String> {
                                        
                                        newsItem.facetPerson.removeAll()
                                        
                                        for pf in perF {
                                            
                                            newsItem.facetPerson.append(pf)
                                        }
                                    }
                                    
                                    if let geoF = r["geo_facet"] as? Array<String> {
                                        
                                        newsItem.facetGeo.removeAll()
                                        
                                        for gf in geoF {
                                            
                                            newsItem.facetGeo.append(gf)
                                        }
                                    }
                                    
                                    if let multiM = r["multimedia"] as? Array<AnyObject> {
                                        
                                        newsItem.multimedia.removeAll()
                                        
                                        for mm in multiM {
                                            
                                            let mMedia = Multimedia()
                                            
                                            if let m = mm as? Dictionary<String, AnyObject> {
                                                
                                                if let urlStr = m["url"] as? String {
                                                    mMedia.url = urlStr
                                                }
                                                
                                                if let form = m["format"] as? String {
                                                    mMedia.format = form
                                                }
                                            
                                                if let hi = m["height"] as? Int {
                                                    mMedia.height = hi
                                                }
                                                
                                                if let wi = m["width"] as? Int {
                                                    mMedia.width = wi
                                                }
                                                
                                                if let typ = m["type"] as? String {
                                                    mMedia.type = typ
                                                }
                                                
                                                if let styp = m["subtype"] as? String {
                                                    mMedia.subtype = styp
                                                }
                                                
                                                if let cap = m["caption"] as? String {
                                                    mMedia.caption = cap
                                                }
                                                
                                                if let cRight = m["copyright"] as? String {
                                                    mMedia.copyright = cRight
                                                }
                                            }
                                            
                                            newsItem.multimedia.append(mMedia)
                                            
                                        }
                                    }
                                    
                                    self.news.append(newsItem)
                                }
                            }
                        }
                    }
                    
                } catch {
                    print("Could not serialize JSON for news api.")
                }
                
                completion()
                
            })
            
        }.resume()
    }
}