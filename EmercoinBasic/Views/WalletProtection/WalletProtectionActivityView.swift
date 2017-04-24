//
//  WalletProtectionActivityView.swift
//  EmercoinBasic
//

import UIKit

class WalletProtectionActivityView: PopupView {
    
    @IBOutlet weak var titleLabel:UILabel!

    var type:ProtectionViewType = .unlock {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateUI()
    }
    
    func updateUI() {
        
        var text = ""
        
        switch type {
            case .lock:text = "Lock"
            case .unlock:text = "Unlock"
            case .protection:text = "Encrypt"
        default:
            text = "Protection"
        }
        
        text = text + " Wallet"
        
        titleLabel.text = text
    }
    
    deinit {
        print("deinit - WalletProtectionActivityView")
        userInteraction(at: true)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        userInteraction(at: false)
    }
}
