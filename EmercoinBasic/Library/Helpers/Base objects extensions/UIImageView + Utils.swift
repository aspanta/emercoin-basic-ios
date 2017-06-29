//
//  UIImageView + Utils.swift
//  EmercoinBasic
//

import UIKit

let noDisableVerticalScrollTag = 123456

extension UIImageView {
    
    func display(image:UIImage, isAnimation:Bool) {
        
        DispatchQueue.main.async {
            self.image = image
            
            if isAnimation {
                let animation = CABasicAnimation(keyPath: "opacity")
                animation.keyPath = "opacity"
                animation.fromValue = 0.0
                animation.toValue = 1.0
                animation.duration = 0.3
                
                self.layer.add(animation, forKey: "opacity")
            }
        }
    }
}
