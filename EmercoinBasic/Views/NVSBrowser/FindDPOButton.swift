//
//  FindDPOButton.swift
//  EmercoinOne
//

import UIKit

class FindDPOButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        fullyRound(diameter: frame.size.height, borderColor: .clear, borderWidth: 0)
    }

}
