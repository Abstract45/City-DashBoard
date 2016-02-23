//
//  AnimationController.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-26.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class AnimationController: UIViewController {
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var middleViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var menuStackView: UIStackView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    
    
    @IBAction func topTap(sender: AnyObject) {
        
        self.changeViewConstraints(ConstraintSize.viewTallHeight, secondViewHeight: ConstraintSize.viewSmallHeight, thirdViewHeight: ConstraintSize.viewSmallHeight)
    }
    
    @IBAction func middleTap(sender: AnyObject) {
        self.changeViewConstraints(ConstraintSize.viewSmallHeight, secondViewHeight: ConstraintSize.viewTallHeight, thirdViewHeight: ConstraintSize.viewSmallHeight)
    }
    
    @IBAction func bottomTap(sender: AnyObject) {
        self.changeViewConstraints(ConstraintSize.viewSmallHeight, secondViewHeight: ConstraintSize.viewSmallHeight, thirdViewHeight: ConstraintSize.viewTallHeight)
        
    }
    
    var isFirstTap = true
    
    private func changeViewConstraints(firstViewHeight:CGFloat,secondViewHeight:CGFloat, thirdViewHeight:CGFloat) {
        
        if isFirstTap {
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.bottomViewHeight.constant = thirdViewHeight
                self.middleViewHeight.constant = secondViewHeight
                self.topViewHeight.constant = firstViewHeight
                self.menuStackView.distribution = .FillProportionally
            })
        } else {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.menuStackView.distribution = .FillEqually
            })
        }
        isFirstTap = !isFirstTap
        
        
        self.changeXibViews(firstViewHeight, secondView: secondViewHeight, thirdView: thirdViewHeight)
        
        
        
    }
    
    
    func changeXibViews(firstView:CGFloat,secondView:CGFloat,thirdView:CGFloat) {
        
        
        if self.menuStackView.distribution == .FillProportionally {
            if firstView == ConstraintSize.viewTallHeight {
                NSNotificationCenter.defaultCenter().postNotificationName("topViewOpen", object: nil)
                NSNotificationCenter.defaultCenter().postNotificationName("changeMiddleView", object: nil)
                NSNotificationCenter.defaultCenter().postNotificationName("changeBottomView", object: nil)
               
                
            } else if secondView == ConstraintSize.viewTallHeight {
                NSNotificationCenter.defaultCenter().postNotificationName("changeTopView", object: nil)
                NSNotificationCenter.defaultCenter().postNotificationName("changeBottomView", object: nil)
                NSNotificationCenter.defaultCenter().postNotificationName("midViewOpen", object: nil)
                
                
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName("changeMiddleView", object: nil)
                NSNotificationCenter.defaultCenter().postNotificationName("changeTopView", object: nil)
                NSNotificationCenter.defaultCenter().postNotificationName("botViewOpen", object: nil)
            }
        } else {
            NSNotificationCenter.defaultCenter().postNotificationName("resetViews", object: nil)
           
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Turn off constraint errors
        NSUserDefaults.standardUserDefaults().setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
    }
    
    
    
    
}
