//
//  AddAddressView.swift
//  EmercoinOne
//

import UIKit

class AddAddressView: PopupView {

    @IBOutlet weak var nameTextField:UITextField!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var doneButton:UIButton!
    
    var add:((_ name:String) -> (Void))?
    
    var viewModel:ContactViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        
        if viewModel != nil {
            titleLabel.text = "Edit address"
            doneButton.setTitle("Save", for: .normal)
            nameTextField.text = viewModel?.name
        }
    }
    
    @IBAction override func doneButtonPressed(sender:UIButton) {
        
        let name = nameTextField.text
        
        if add != nil && (name?.length)! > 0  {
            add!(name!)
        } else {
            return
        }
        super.doneButtonPressed(sender: sender)
    }
}
