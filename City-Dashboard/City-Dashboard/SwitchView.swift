//
//  SwitchView.swift
//  City-Dashboard
//
//  Created by Alexander Besson on 2016-02-22.
//  Copyright © 2016 Miwand Najafe. All rights reserved.
//

import UIKit

class SwitchView: UIView {
    
    let bgView = UIView()
    let selectorView = UIView()
    
    var isOn = false
    
    let colorOfBackground = UIColor.grayColor()
    let colorOfSelector = UIColor.redColor()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
    }
    
    func configure() {
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        self.userInteractionEnabled = true
        
        bgView.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        bgView.backgroundColor = colorOfBackground
        
        selectorView.frame = CGRectMake(0, 0, self.frame.width / 2, self.frame.height)
        selectorView.backgroundColor = colorOfSelector
        selectorView.layer.cornerRadius = 4
        selectorView.clipsToBounds = true
        
        self.addSubview(bgView)
        bgView.addSubview(selectorView)
        
        addGesture()
    }
    
    func addGesture() {
        
        self.userInteractionEnabled = true
        
        let getsture = UITapGestureRecognizer(target: self, action: "performOnTap:")
        self.addGestureRecognizer(getsture)
    }
    
    func performOnTap(getsture: UITapGestureRecognizer) {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.switchSelection()
            
            }) { (completed) -> Void in
                
        }
    }
    
    func switchSelection() {
        
        if isOn == false {
            selectorView.frame = CGRectMake(self.frame.width / 2, 0, self.frame.width / 2, self.frame.height)
        } else {
            selectorView.frame = CGRectMake(0, 0, self.frame.width / 2, self.frame.height)
        }
        
        isOn = !isOn
        
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
