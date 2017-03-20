//
//  CoinOperationsViewModel.swift
//  EmercoinOne
//


import UIKit
import RxSwift
import RxCocoa

class CoinOperationsViewModel {
    
    
    let disposeBag = DisposeBag()

    var coinCourseTitle = PublishSubject<NSAttributedString>()
    var coinAmount = PublishSubject<String>()
    var coinSign = PublishSubject<String>()
    
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
}
