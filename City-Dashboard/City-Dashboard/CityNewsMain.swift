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
 
    @IBOutlet weak var vwBottom: UIView!
    
    @IBOutlet weak var logoRightConstraint: NSLayoutConstraint!

    @IBOutlet weak var lblDailyHeadlines: UILabel!
    
    @IBOutlet weak var newsTableView: UITableView!
    
    @IBOutlet weak var lblNewsCategory: UILabel!
    @IBOutlet weak var imgNewsLogo: UIImageView!
    @IBOutlet weak var vwTop: UIView!
    
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
        cell.timeCategory.text = newsArray[indexPath.row].dateCreated
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in    
        cell.imgCityNews.imageFromUrl(self.newsArray[indexPath.row].multimedia[0].url)
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
    
    
   
    
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//       var currentOffset = scrollView.contentOffset
//        var lastContentOffset: CGPoint = CGPoint(x: 0, y: 0)
//        if (currentOffset.y > lastContentOffset.y)
//        {
//            // Downward
//            
//            
//            botShadow(true)
//            topShadow(false)
//        }
//        else {
//            // Upward
//           
//            topShadow(true)
//            botShadow(false)
//        }
//      lastContentOffset = currentOffset
//    }
//    
//    func topShadow(isScrolledBot:Bool) {
//        if isScrolledBot {
//            print("Hit")
//            let shadowPath = UIBezierPath(rect: self.vwTop.bounds)
//            vwTop.layer.masksToBounds = false
//            vwTop.layer.shadowColor = UIColor.blackColor().CGColor
//            vwTop.layer.shadowOffset = CGSize(width: 0, height: 1)
//            vwTop.layer.shadowOpacity = 0.5
//            vwTop.layer.shadowPath = shadowPath.CGPath
//        } else {
//            vwTop.layer.shadowOpacity = 0
//        }
//    }
//    func botShadow(isScrolledTop:Bool) {
//        if isScrolledTop {
//            print("Hit2")
//            let shadowPath = UIBezierPath(rect: self.vwBottom.bounds)
//            vwBottom.layer.masksToBounds = false
//            vwBottom.layer.shadowColor = UIColor.blackColor().CGColor
//            vwBottom.layer.shadowOffset = CGSize(width: 5, height: 0)
//            vwBottom.layer.shadowOpacity = 0.5
//            vwBottom.layer.shadowPath = shadowPath.CGPath
//        } else {
//            vwBottom.layer.shadowOpacity = 0
//        }
//        
//    }

}
