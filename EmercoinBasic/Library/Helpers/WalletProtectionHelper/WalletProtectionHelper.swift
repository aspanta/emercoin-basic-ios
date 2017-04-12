//
//  WalletProtectionHelper.swift
//  EmercoinBasic
//

import UIKit

enum ProtectionViewType:Int {
    case unlock = 0
    case lock = 1
    case protection = 2
    case warning = 3
}

class WalletProtectionHelper {
    
    var fromController:UIViewController?
    var wallet = AppManager.sharedInstance.wallet
    
    func startProtection() {
        
        if wallet.isProtected {
            if wallet.isLocked {
                showUnlockView()
            } else {
                showLockView()
            }
        } else {
            showProtectionView()
        }
        
    }
    
    private func showUnlockView() {
        
        let view = getProtectionView(at: .unlock) as! WalletProtectionUnlockView
        view.unlock = {(password) in
            self.wallet.unlock(at:password)
        }
        showView(at: view)
    }
    
    private func showLockView() {
        
        let view = getProtectionView(at: .lock) as! WalletProtectionLockView
        view.lock = {
            self.wallet.lock()
        }
        showView(at: view)
    }
    
    private func showProtectionView() {
        
        let view = getProtectionView(at: .protection) as! WalletProtectionView
        view.encrypt = {(password) in
            
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: { 
                self.showWarningView(at: password)
            })

        }
        showView(at: view)
    }
    
    private func showWarningView(at text:String) {
        
        let view = getProtectionView(at: .warning) as! WalletProtectionWarningView
        view.encrypt = {
            self.wallet.protect(at:text)
        }
        showView(at: view)
    }
    
    private func getProtectionView(at type:ProtectionViewType) -> UIView {
        
        let view = loadViewFromXib(name: "WalletProtection", index: type.rawValue)
        return view
    }
    
    private func showView(at view:UIView) {
        
        if let controller = self.fromController {
            view.frame = controller.view.frame
            controller.view.addSubview(view)
        }
    }
}
