//
//  NewsVC.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-02-01.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class NewsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var newsMainView: CityNewsMain!
    @IBOutlet weak var newsTableView: UITableView!
    
 
    private var indexValue: NSIndexPath?
    private var currentURL:String? = ""
    private var newsArray = [NewsItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.populateNews()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeNewsXib:", name: "changeBottomView", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetNewsXib:", name: "resetViews", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "botOpen:", name: "botViewOpen", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "segueToWeb:", name: "segueToWebView", object: nil)
        
    }
    
    
    // Table functions
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  newsArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 91
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        newsTableView.registerNib(UINib.init(nibName: "CityNewsCell", bundle: nil), forCellReuseIdentifier:"news")
        let cell = newsTableView.dequeueReusableCellWithIdentifier("news") as! CityNewsCell
        
        cell.headlines.text = newsArray[indexPath.row].title
        cell.timeCategory.text = newsArray[indexPath.row].dateCreated
        cell.url = newsArray[indexPath.row].url
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if let url  = NSURL(string: self.newsArray[indexPath.row].multimedia[0].url),
                data = NSData(contentsOfURL: url)
            {
                cell.imgCityNews.image = UIImage(data: data)
            }
        }
        
        
        return cell
    }
    
    
    
    
    
    // Get news method
    
   private func populateNews() -> [NewsItem] {
        let news = News()
        
        news.downloadNews { () -> () in
            
            self.newsArray = news.news
            self.newsTableView.reloadData()
        }
        return newsArray
    }
    
    
    // Animations for views
    func changeNewsXib(notification:NSNotification) {
        UIView.animateWithDuration(1) { () -> Void in
            self.newsMainView.logoRightConstraint.constant = ConstraintSize.midSizeLogo
            self.newsMainView.lblDailyHeadlines.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func botOpen(notification:NSNotification) {
        UIView.animateWithDuration(1) { () -> Void in
            self.newsMainView.lblNewsCategory.alpha = 0
            self.newsMainView.imgNewsLogo.alpha = 0
        }
    }
    
    func resetNewsXib(notification:NSNotification) {
        UIView.animateWithDuration(1) { () -> Void in
            
            self.newsMainView.logoRightConstraint.constant = 22
            self.newsMainView.lblNewsCategory.alpha = 1
            self.newsMainView.imgNewsLogo.alpha = 1
            self.newsMainView.lblDailyHeadlines.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    
    // Segue to Web method
    func segueToWeb(notification:NSNotification) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryBoard.instantiateViewControllerWithIdentifier("NewsWebVC")
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    
    
}
