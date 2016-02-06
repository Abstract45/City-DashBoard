//
//  NewsWebVC.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-02-05.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class NewsWebVC: UIViewController {
    
    var newsUrl:String = "http://www.nytimes.com/2014/12/03/business/economy/uncertainty-in-washington-poses-long-list-of-economic-perils.html?_r=0"
    
    @IBOutlet weak var newsWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsUrl = NSUserDefaults.standardUserDefaults().objectForKey("currentURL") as! String
        loadWebView()
        
    }
    
    
    
    
    func loadWebView() {
        
        
        if let url = NSURL(string: newsUrl) {
            let request = NSURLRequest(URL: url)
            
            newsWebView.loadRequest(request)
        }
    }
    
    
    
    @IBAction func closeWebView(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}
