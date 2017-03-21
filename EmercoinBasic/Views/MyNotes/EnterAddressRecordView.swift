//
//  EnterAddressRecordView.swift
//  EmercoinBasic
//

import UIKit

class EnterAddressRecordView: PopupView {

    @IBOutlet internal weak var addressTextField:BaseTextField!

    var text:((_ text:String) -> (Void))?

    @IBAction override func doneButtonPressed(sender:UIButton) {
        
        if text != nil {
            text!(addressTextField.text!)
        }
        super.doneButtonPressed(sender: sender)
    }
}
