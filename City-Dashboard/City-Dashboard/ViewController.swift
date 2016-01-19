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
        
        if isFirstTap {
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.greenHeight.constant = 0
                self.orangeHeight.constant = 0
                self.tealHeight.constant = self.view.frame.height
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
        
        if isFirstTap {
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.greenHeight.constant = 0
                self.tealHeight.constant = 0
                self.orangeHeight.constant = self.view.frame.height
                self.stacVIew.distribution = .FillProportionally
            })
       
        } else {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.stacVIew.distribution = .FillEqually
            })
        }
        
        
        
        isFirstTap = !isFirstTap
        
    }
    
    @IBAction func greenTap(sender: AnyObject) {
        if isFirstTap {
        UIView.animateWithDuration(1) { () -> Void in
            self.orangeHeight.constant = 0
            self.tealHeight.constant = 0
            self.greenHeight.constant = self.view.frame.height
            
            self.stacVIew.distribution = .FillProportionally
        }
        }
        else {
            UIView.animateWithDuration(1, animations: { () -> Void in
                 self.stacVIew.distribution = .FillEqually
            })
           
        }
        isFirstTap = !isFirstTap
    }
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }


}

