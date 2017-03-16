//
//  UIImageView + Utils.swift
//  VKApp
//
//  Created by Sergey Lyubeznov on 27/01/2017.
//  Copyright © 2017 Sergey Lyubeznov. All rights reserved.
//

import UIKit

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
