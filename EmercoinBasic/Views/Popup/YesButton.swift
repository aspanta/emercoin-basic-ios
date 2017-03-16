//
//  YesButton.swift
//  EmercoinOne
//

import UIKit

class YesButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        round(corners: [.bottomLeft,.topLeft], radius: 15)
    }

}
