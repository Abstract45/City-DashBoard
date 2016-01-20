//
//  MenuContoller.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-17.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class MenuController: UIViewController {
    
    @IBOutlet weak var menuStack: UIStackView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var midViewHeight: NSLayoutConstraint!
    @IBOutlet weak var botViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    var isFirstTap = true
    
    
    
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
    
    @IBAction func midViewTap(sender: AnyObject) {
        
        self.changeViewConstraints(50, secondViewHeight: self.view.frame.height - 100, thirdViewHeight: 50)
        
    }
    @IBAction func topViewTap(sender: AnyObject) {
        
        
        self.changeViewConstraints(self.view.frame.height - 100, secondViewHeight: 50, thirdViewHeight: 50)
        
    }
    
    @IBAction func botViewTap(sender: AnyObject) {
        
        self.changeViewConstraints(50, secondViewHeight: 50, thirdViewHeight: self.view.frame.height - 100)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
}

