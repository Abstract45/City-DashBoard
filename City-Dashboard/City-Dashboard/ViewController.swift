//
//  ViewController.swift
//  City-Dashboard
//
//  Created by Miwand Najafe on 2016-01-17.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stacVIew: UIStackView!
    @IBOutlet weak var tealView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var tealHeight: NSLayoutConstraint!
    @IBOutlet weak var greenHeight: NSLayoutConstraint!
    @IBOutlet weak var orangeHeight: NSLayoutConstraint!
    
    var isFirstTap = true

    @IBAction func tealTap(sender: AnyObject) {
        
      self.changeViewConstraints(50, secondViewHeight: self.view.frame.height - 100, thirdViewHeight: 50)
        
    }
    
    private func changeViewConstraints(firstViewHeight:CGFloat,secondViewHeight:CGFloat, thirdViewHeight:CGFloat) {
       
            if isFirstTap {
                
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.greenHeight.constant = thirdViewHeight
                    self.tealHeight.constant = secondViewHeight
                    self.orangeHeight.constant = firstViewHeight
                    self.stacVIew.distribution = .FillProportionally
                })
                
            } else {
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.stacVIew.distribution = .FillEqually
                })
            
            
        }
        isFirstTap = !isFirstTap
    }
    
    @IBAction func orangeTap(sender: AnyObject) {
     
        
        self.changeViewConstraints(self.view.frame.height - 100, secondViewHeight: 50, thirdViewHeight: 50)
        
    }
    
    @IBAction func greenTap(sender: AnyObject) {
       
        self.changeViewConstraints(50, secondViewHeight: 50, thirdViewHeight: self.view.frame.height - 100)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

 

}

