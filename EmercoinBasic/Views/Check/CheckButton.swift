//
//  CheckButton.swift
//  EmercoinOne
//
//  Created by Sergey Lyubeznov on 24/02/2017.
//  Copyright © 2017 Aspanta. All rights reserved.
//

import UIKit

class CheckButton: UIButton {
    
    var isChecked:Bool = false {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        let image = isChecked ? "check_on" : "check_off"
        setImage(UIImage(named: image), for: .normal)
    }
}
