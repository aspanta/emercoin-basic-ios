//
//  History.swift
//  EmercoinBasic
//

import UIKit
import RxCocoa
import RxSwift


class History: NSObject {

    private var transactionList:[HistoryTransaction] = []
    
    var transactions:[HistoryTransaction] {
        get {
            return transactionList.sorted(by: { (tr1, tr2) -> Bool in
                return tr1.timereceived > tr2.timereceived
            })
        }
    }
    
    let disposeBag = DisposeBag()
    var success = PublishSubject<Bool>()
    var error = PublishSubject<Error>()
    var activityIndicator = PublishSubject<Bool>()
    
    func add(transaction:HistoryTransaction) {
        transactionList.append(transaction)
    }
    
    func remove(transaction:HistoryTransaction) {
        transactionList.remove(object: transaction)
    }
    
    func removeAll() {
        transactionList.removeAll()
    }
    
    func load() {
        
        activityIndicator.onNext(true)
        
        APIManager.sharedInstance.loadTransactions {[weak self] (data, error) in
            self?.activityIndicator.onNext(false)
            if error == nil {
                guard let transactions = data as? [HistoryTransaction] else {
                    return
                }
                self?.transactionList = transactions
                self?.success.onNext(true)
            } else {
                self?.error.onNext(error!)
            }
        }
    }
}
