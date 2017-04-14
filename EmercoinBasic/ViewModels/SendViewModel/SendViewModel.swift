//
//  SendViewModel.swift
//  EmercoinBasic
//


import UIKit

class SendViewModel: CoinOperationsViewModel {

    override init() {
        super.init()
        
        wallet?.locked.subscribe(onNext: {[weak self] (state) in
            self?.updateUI()
            if state == false {
                if let amountData = self?.wallet?.amountData {
                    self?.sendCoins(at: amountData)
                }
            }
        })
            .addDisposableTo(disposeBag)
    }
    
    func checkWalletAndSend(at sendData:AnyObject) {
        wallet?.loadInfo(completion: {[weak self] in
            if self?.wallet?.isLocked == true {
                self?.walletLock.onNext(true)
                self?.wallet?.amountData = sendData
                return
            } else {
                self?.sendCoins(at: sendData)
            }
        })
    }
    
    func sendCoins(at sendData:AnyObject) {
        
        if isLoading {return}
        
        activityIndicator.onNext(true)
        isLoading = true
        
        APIManager.sharedInstance.sendCoins(at: sendData) {[weak self] (data, error) in
            self?.wallet?.amountData = nil
            self?.activityIndicator.onNext(false)
            self?.isLoading = false
            
            if error != nil {
                self?.error.onNext(error!)
            } else {
                if let success = data as? Bool {
                    self?.success.onNext(success)
                }
            }
        }
    }
}
