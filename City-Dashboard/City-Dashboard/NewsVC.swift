//
//  NewsVC.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-02-01.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class NewsVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet var newsMainView: CityNewsMain!
    private var midSize:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
         midSize = self.newsMainView.frame.midX - 51.5
       
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeNewsXib:", name: "changeBottomView", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetNewsXib:", name: "resetViews", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "botOpen:", name: "botViewOpen", object: nil)
        
      
        
        
        
    }
    
    func changeNewsXib(notification:NSNotification) {
        UIView.animateWithDuration(1) { () -> Void in
            self.newsMainView.logoRightConstraint.constant = self.midSize
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
    
   
    

}
