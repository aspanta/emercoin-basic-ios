//
//  PutOrderView.swift
//  EmercoinOne
//

import UIKit

class PutOrderView: PopupView {
    
    var title:String? {
        didSet {
            doneButton.setTitle(title ?? "", for: .normal)
        }
    }
    
    @IBOutlet weak var doneButton:UIButton!


    @IBAction override func doneButtonPressed(sender:UIButton) {
        
        super.doneButtonPressed(sender: sender)
    }
}
