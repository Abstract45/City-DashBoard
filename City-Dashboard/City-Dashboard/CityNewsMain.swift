//
//  CityNewsMain.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-29.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

 class CityNewsMain: UIView, UITableViewDataSource, UITableViewDelegate {
 private var view: UIView!
 
    
    @IBOutlet weak var logoRightConstraint: NSLayoutConstraint!

    @IBOutlet weak var lblDailyHeadlines: UILabel!
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var newsArray = [NewsItem]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup()
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    private func xibSetup() {
        view = loadViewFromNib()
        
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        addSubview(view)
    }
    
 
    private func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CityNewsMain", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        populateNews()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  newsArray.count
    }
    
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        newsTableView.registerNib(UINib.init(nibName: "CityNewsCell", bundle: nil), forCellReuseIdentifier:"news")
        let cell = newsTableView.dequeueReusableCellWithIdentifier("news") as! CityNewsCell
        cell.headlines.text = newsArray[indexPath.row].title
        cell.timeCategory.text = newsArray[indexPath.row].datePublished ?? ""
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in    
        cell.imgCityNews.imageFromUrl(self.newsArray[indexPath.row].multimedia[0].url ?? "")
        }
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 91
    }
    
    func populateNews() -> [NewsItem] {
        let news = News()
        
        news.downloadNews { () -> () in
            
            self.newsArray = news.news
            
            
            self.newsTableView.reloadData()
        }
        return newsArray
    }
    
    
    

}
