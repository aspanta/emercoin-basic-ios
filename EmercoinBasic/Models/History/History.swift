//
//  History.swift
//  EmercoinBasic
//

import UIKit
import RxCocoa
import RxSwift
import RealmSwift


class History: NSObject {
    
    var transactions:Results<HistoryTransaction> {
        
        let realm = try! Realm()
        return realm.objects(HistoryTransaction.self).sorted(byKeyPath: "timereceived", ascending: false)
    }
    
    let disposeBag = DisposeBag()
    var success = PublishSubject<Bool>()
    var error = PublishSubject<NSError>()
    var activityIndicator = PublishSubject<Bool>()
    
    func add(transaction:HistoryTransaction) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(transaction)
        }
    }
    
    func add(transactions:[HistoryTransaction]) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(transactions)
        }
    }
    
    func remove(transaction:HistoryTransaction) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(transaction)
        }
    }
    
    func removeAll() {
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(transactions)
        }
    }
    
    func load() {
    
        APIManager.sharedInstance.loadTransactions {[weak self] (data, error) in
            self?.activityIndicator.onNext(false)
            
            if let error = error {
                self?.error.onNext(error)
            } else {
                if let transactions = data as? [HistoryTransaction] {
                    self?.removeAll()
                    self?.add(transactions: transactions)
                    self?.success.onNext(true)
                }
            }
        }
    }
}
