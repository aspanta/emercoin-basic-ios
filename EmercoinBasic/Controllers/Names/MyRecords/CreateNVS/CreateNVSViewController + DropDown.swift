//
//  CreateNVSViewController + DropDown.swift
//  EmercoinBasic
//

import UIKit

extension CreateNVSViewController {
    
    internal func setupPrefixDropDown() {
        
        prefixDropDown = DropDown()
        prefixDropDown?.anchorView = prefixButton
        
        let dataSource = ["Any", "dns", "ssh", "dpo"]
        
        prefixDropLabel.text = dataSource.first
        
        prefixDropDown?.dataSource = dataSource
        
        prefixDropDown?.selectionAction = { [unowned self] (index, item) in
            self.prefixDropLabel.text = item
            self.prefixLabel.text = index != 0 ? item+":" : ""
        }
        
        prefixDropDown?.bottomOffset = CGPoint(x: 0, y: prefixButton.bounds.height)
        
        setupDropDownUI()
        
    }
    
    internal func setupDropDownUI() {
        
        let appearance = DropDown.appearance()
        appearance.selectionBackgroundColor = prefixDropLabel.textColor
        appearance.cellHeight = prefixButton.bounds.height + 7
        appearance.textFont = UIFont(name: "Roboto-Regular", size: 18)!
    }
}
