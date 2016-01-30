//
//  MenuContoller.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-17.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class MenuController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    
    @IBOutlet weak var menuStack: UIStackView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var midViewHeight: NSLayoutConstraint!
    @IBOutlet weak var botViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var middleTable: UITableView!
    @IBOutlet weak var bottomTable: UITableView!
   

   
    
    var isFirstTap = true
    var isMiddleHidden = false
    
    // Animate views
    
    private func changeViewConstraints(firstViewHeight:CGFloat,secondViewHeight:CGFloat, thirdViewHeight:CGFloat) {
        
        if isFirstTap {
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.botViewHeight.constant = thirdViewHeight
                self.midViewHeight.constant = secondViewHeight
                self.topViewHeight.constant = firstViewHeight
                self.menuStack.distribution = .FillProportionally
                
            })
            
        } else {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.menuStack.distribution = .FillEqually
            })
            
            
        }
        isFirstTap = !isFirstTap
        
    }
    
    // Animation buttons
    
    
    @IBAction func midViewTap(sender: AnyObject) {
        
        self.changeViewConstraints(50, secondViewHeight: self.view.frame.height - 100, thirdViewHeight: 50)
        self.bottomTable.hidden = !isFirstTap
        self.middleTable.hidden = false
        
    }
    @IBAction func topViewTap(sender: AnyObject) {
        
        
        self.changeViewConstraints(self.view.frame.height - 80, secondViewHeight: 40, thirdViewHeight: 40)
        self.bottomTable.hidden = !isFirstTap
        self.middleTable.hidden = !isFirstTap
        
        
        
        
        
    }
    
    @IBAction func botViewTap(sender: AnyObject) {
        
        self.changeViewConstraints(50, secondViewHeight: 50, thirdViewHeight: self.view.frame.height - 100)
        
        self.middleTable.hidden = !isFirstTap
        self.bottomTable.hidden = false
    
        
    }
    
    
    // Tables
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch tableView {
        case middleTable:
            
            let cell = middleTable.dequeueReusableCellWithIdentifier("middle")
            
            
            
            return cell!
//        case bottomTable:
//           
           
            
            
//                bottomTable.registerNib(UINib.init(nibName: "CityNewsMain", bundle: nil), forCellReuseIdentifier: "news")
//                
//                
//                let cell = bottomTable.dequeueReusableCellWithIdentifier("news") as! CityNewsMain
//                return cell
            
            
            
        default:
            let cell = UITableViewCell()
            return cell
        }
        
        
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case middleTable:
            return 2
        case bottomTable:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView == bottomTable {
            if indexPath.row == 0 {
                return 130
            } else {
                return 42
            }
        }
        return 160
    }
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
      
    }
    
    
    
}

