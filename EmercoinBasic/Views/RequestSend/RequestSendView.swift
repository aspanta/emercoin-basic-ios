//
//  RequestSendView.swift
//  EmercoinBasic
//

import UIKit

class RequestSendView: PopupView {
    
    @IBOutlet weak var amountLabel:UILabel?
    
    var sendCoins:((Void) -> (Void))?
    
    @IBAction override func doneButtonPressed(sender:UIButton) {
        if sendCoins != nil {
            sendCoins!()
            cancelButtonPressed(sender: nil)
        }
        super.doneButtonPressed(sender: sender)
    }
}
