//
//  MenuPoliticsCell.swift
//  EmercoinOne
//

import UIKit

class MenuPoliticsCell: MenuDefaultCell {
    
    @IBAction func subMenuButtonPresed() {
        if self.pressedSubMenu != nil {
            self.pressedSubMenu!(1)
        }
    }

}
