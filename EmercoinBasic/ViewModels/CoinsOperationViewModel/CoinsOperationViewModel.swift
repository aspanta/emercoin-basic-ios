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
    var error = PublishSubject<NSError>()
    var activityIndicator = PublishSubject<Bool>()
    var wallet:Wallet?
    
    private var isLoading = false
    
    func updateUI() {
    
        if wallet != nil {
            
            let coin = wallet?.emercoin
            
            let courseTitle = coin?.exchangeAttributedString(color: .white)
            let sign = coin?.sign
            let stringAmount = String(format:"%@ %@",String.coinFormat(at:(coin?.amount)!),sign ?? "")
            
            coinCourseTitle.onNext(courseTitle!)
            coinAmount.onNext(stringAmount)
            coinSign.onNext(sign ?? "")
        }
    }
    
    init() {
        
        wallet = AppManager.sharedInstance.wallet
        
        if wallet != nil {
            
            wallet?.success.subscribe(onNext: {[weak self] (state) in
                self?.updateUI()
            })
            .addDisposableTo(disposeBag)
        }
        
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
