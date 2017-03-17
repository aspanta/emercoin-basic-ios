//
//  GetCoinsViewController + DropDown.swift
//  EmercoinOne
//

import UIKit

extension GetCoinsViewController {
    
    internal func setupDropDown() {
        
        let myAddressBook = AppManager.sharedInstance.myAddressBook
                
        dropDown = DropDown()
        dropDown?.anchorView = dropDownButton
        
        let addresses = myAddressBook.addressesArray()
        
        addressLabel.text = addresses.first
        
        dropDown?.dataSource = addresses
        
        dropDown?.selectionAction = { [unowned self] (index, item) in
            self.addressLabel.text = item
            self.generateQRCode()
        }
        
        dropDown?.bottomOffset = CGPoint(x: 0, y: dropDownButton.bounds.height)

        setupDropDownUI()
        
    }
    
    internal func setupDropDownUI() {
        
        let appearance = DropDown.appearance()
        appearance.selectionBackgroundColor = coinSignLabel.textColor
        appearance.cellHeight = dropDownButton.bounds.height + 5
        appearance.textFont = UIFont(name: "Roboto-Regular", size: 18)!
    }
    
    
    @IBAction func dropButtonPressed() {
        
        dropDown?.show()
    }
}
