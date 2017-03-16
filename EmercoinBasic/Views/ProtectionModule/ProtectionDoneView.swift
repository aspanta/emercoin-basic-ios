//
//  ProtectionDoneView.swift
//  EmercoinOne
//

import UIKit

class ProtectionDoneView: UIView {

    var done:((Void) -> (Void))?
    
    @IBAction func doneButtonPressed() {
        
        if done != nil {
            done!()
        }
    
    }

}
