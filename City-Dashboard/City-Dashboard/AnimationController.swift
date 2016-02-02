//
//  AnimationController.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-26.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class AnimationController: UIViewController {
    
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var middleViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var menuStackView: UIStackView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    private var smallHeight:CGFloat = 0
    private var tallHeight:CGFloat = 0
    
    static var mainViewSize: CGFloat {
        return self.init().view.frame.midX - 51.5
    }
    
    
    
    @IBAction func topTap(sender: AnyObject) {
        
        self.changeViewConstraints(tallHeight, secondViewHeight: smallHeight, thirdViewHeight: smallHeight)
    }
    
    @IBAction func middleTap(sender: AnyObject) {
        self.changeViewConstraints(smallHeight, secondViewHeight: tallHeight, thirdViewHeight: smallHeight)
    }
    
    @IBAction func bottomTap(sender: AnyObject) {
        self.changeViewConstraints(smallHeight, secondViewHeight: smallHeight, thirdViewHeight: tallHeight)
        
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
            if firstView == tallHeight {
                NSNotificationCenter.defaultCenter().postNotificationName("topViewOpen", object: nil)
                NSNotificationCenter.defaultCenter().postNotificationName("changeMiddleView", object: nil)
                NSNotificationCenter.defaultCenter().postNotificationName("changeBottomView", object: nil)
                
                
            } else if secondView == tallHeight {
                NSNotificationCenter.defaultCenter().postNotificationName("changeTopView", object: nil)
                NSNotificationCenter.defaultCenter().postNotificationName("changeBottomView", object: nil)
                NSNotificationCenter.defaultCenter().postNotificationName("midViewOpen", object: nil)
                
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName("changeMiddleView", object: nil)
                NSNotificationCenter.defaultCenter().postNotificationName("changeTopView", object: nil)
            }
        } else {
            NSNotificationCenter.defaultCenter().postNotificationName("resetViews", object: nil)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        smallHeight = 38
        tallHeight = self.view.bounds.height - smallHeight
        
        //Turn off constraint errors
        NSUserDefaults.standardUserDefaults().setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
    }
    
    
    
    
}
