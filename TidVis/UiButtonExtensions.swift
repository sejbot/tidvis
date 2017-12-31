//
//  UiButtonExtensions.swift
//  TidVis
//
//  Created by Tobias Glosboken on 2017-12-30.
//  Copyright © 2017 Bulleriberg. All rights reserved.
//

import UIKit;

extension UIButton {
    func flashBetweenColors(fromColor: UIColor, toColor: UIColor) {
        
        let flash = CABasicAnimation(keyPath: "backgroundColor")
        flash.duration = 0.3
        flash.fromValue = fromColor.cgColor
        flash.toValue = toColor.cgColor
        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 10
        
        layer.add(flash, forKey: nil)
    }
}
