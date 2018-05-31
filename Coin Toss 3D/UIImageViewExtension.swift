//
//  UIImageViewExtension.swift
//  Coin Toss 3D
//
//  Created by Eduard Caziuc on 24/04/2018.
//  Copyright © 2018 Eduard Caziuc. All rights reserved.
//

import UIKit

extension UIView {
    
    func rotate360Degrees(duration: CFTimeInterval = 0.90, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 20)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = (delegate as! CAAnimationDelegate)
        }
        self.layer.add(rotateAnimation, forKey: nil)
    }
}
