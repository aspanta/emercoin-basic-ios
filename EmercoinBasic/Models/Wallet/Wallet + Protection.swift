//
//  Wallet + Protection.swift
//  EmercoinBasic
//

import UIKit

extension Wallet {
    
    func protect(at password:String) {
        
        APIManager.sharedInstance.protectWallet(at: [password] as AnyObject) {[weak self] (data, error) in
            self?.loadInfoOrShowError(at: error)
        }
    }
    
    func unlock(at password:String) {
        
        APIManager.sharedInstance.unlockWallet(at: [password, 3000] as AnyObject) {[weak self] (data, error) in
            self?.loadInfoOrShowError(at: error)
        }
    }
    
    func lock() {
        
        APIManager.sharedInstance.lockWallet {[weak self] (data, error) in
            self?.loadInfoOrShowError(at: error)
        }
    }
    
    func loadInfoOrShowError(at error:NSError?) {
        
        if let error = error {
            self.error.onNext(error)
        } else {
            self.loadInfo()
        }
    }
}
