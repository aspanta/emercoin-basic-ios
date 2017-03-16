//
//  LoginButton.swift
//  EmercoinOne
//

import UIKit

class LoginButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        fullyRound(diameter: 8, borderColor: .clear, borderWidth: 0)
    }
}
