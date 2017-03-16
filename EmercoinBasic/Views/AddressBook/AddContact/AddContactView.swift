//
//  AddContactView.swift
//  EmercoinOne
//

import UIKit

class AddContactView: PopupView {

    @IBOutlet weak var nameTextField:UITextField!
    @IBOutlet weak var addressTextField:UITextField!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var doneButton:UIButton!

    var add:((_ name:String, _ address:String) -> (Void))?
    
    var viewModel:ContactViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        
        if viewModel != nil {
            titleLabel.text = "Edit contact"
            doneButton.setTitle("Save", for: .normal)
            nameTextField.text = viewModel?.name
            addressTextField.text = viewModel?.address
        }
    }
    
    @IBAction override func doneButtonPressed(sender:UIButton) {
        
        let name = nameTextField.text
        let address = addressTextField.text
        
        if add != nil && ((name?.length)! > 0 && (address?.length)! > 0 ) {
            add!(name!, address!)
        } else {
            return
        }
        super.doneButtonPressed(sender: sender)
    }
}
