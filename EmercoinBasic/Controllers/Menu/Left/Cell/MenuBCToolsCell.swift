//
//  MenuBCToolsCell.swift
//  EmercoinOne
//

import UIKit

class MenuBCToolsCell: MenuDefaultCell {
    
    
    @IBAction func subMenuButtonPresed(sender:UIButton) {
        
        let index = sender.tag
        
        if self.pressedSubMenu != nil {
            self.pressedSubMenu!(index)
        }
    }

}
