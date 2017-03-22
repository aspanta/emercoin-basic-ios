//
//  CoinOperationsViewModel.swift
//  EmercoinBasic
//


import UIKit
import RxSwift
import RxCocoa

class CoinOperationsViewModel {
    
    
    let disposeBag = DisposeBag()

    var coinCourseTitle = PublishSubject<NSAttributedString>()
    var coinAmount = PublishSubject<String>()
    var coinSign = PublishSubject<String>()
    
    var success = PublishSubject<Bool>()
    var error = PublishSubject<Error>()
    var activityIndicator = PublishSubject<Bool>()
    
    private var isLoading = false
    
    func updateUI() {
        
        guard let wallet = AppManager.sharedInstance.wallet else {
            return
        }
        
        let courseTitle = wallet.emercoin.exchangeAttributedString(color: .white)
        let amount = wallet.emercoin.amount
        let sign = wallet.emercoin.sign
        
        coinCourseTitle.onNext(courseTitle)
        coinAmount.onNext(String(format:"%0.2f",amount ?? 0))
        coinSign.onNext(sign ?? "")
    }
    
    func sendCoins(at sendData:AnyObject) {
        
        if isLoading {return}
        
        activityIndicator.onNext(true)
        isLoading = true
        
        APIManager.sharedInstance.sendCoins(at: sendData) {[weak self] (data, error) in
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
