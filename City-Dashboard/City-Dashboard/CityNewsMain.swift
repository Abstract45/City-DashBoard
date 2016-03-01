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
    
    @IBOutlet weak var lblNewsCategory: UILabel!
    @IBOutlet weak var imgNewsLogo: UIImageView!
    @IBOutlet weak var vwTop: UIView!
    var indexValue: NSIndexPath?
    var currentURL:String? = ""
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
       view.frame = UIScreen.mainScreen().bounds
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
        addGradient()
      
    }
    
    func addGradient(){
        
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = self.view.frame.size
        gradient.colors =
            [UIColor(red: 53/255, green: 122/255, blue: 116/255, alpha: 1.0).CGColor,
        UIColor(red: 123/255, green: 226/255, blue: 220/255, alpha: 0.9).CGColor];
            //[UIColor.grayColor().CGColor,UIColor.blackColor().colorWithAlphaComponent(0).CGColor] //Or any colors
        self.view.layer.addSublayer(gradient)
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  newsArray.count
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