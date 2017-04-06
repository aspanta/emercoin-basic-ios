//
//  BCNotes.swift
//  EmercoinBasic
//

import UIKit
import RxCocoa
import RxSwift
import RealmSwift
import RxRealm

class Records {
    
    var records:Results<Record> {
        get {
            let realm = try! Realm()
            return realm.objects(Record.self)
        }
    }
    
    let disposeBag = DisposeBag()
    var success = PublishSubject<Bool>()
    var error = PublishSubject<NSError>()
    var activityIndicator = PublishSubject<Bool>()
    var isEmpty = PublishSubject<Bool>()
    
    init() {
        
        Observable.changeset(from: records)
            .subscribe(onNext: {results, changes in
                self.isEmpty.onNext(results.count == 0)
                
                if changes?.inserted.count != 0 || changes?.updated.count != 0 {
                    self.success.onNext(true)
                }
            })
            .addDisposableTo(disposeBag)
    }
    
    func add(record:Record) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(record)
        }
    }
    
    func add(records:[Record]) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(records)
        }
    }
    
    func remove(record:Record) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(record)
        }
    }
    
    func removeAll() {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(records)
        }
    }
    
    func load() {
        
        APIManager.sharedInstance.loadNames {[weak self] (data, error) in
            self?.activityIndicator.onNext(false)
            if error == nil {
                guard let records = data as? [Record] else {
                    return
                }
                self?.removeAll()
                self?.add(records: records.filter({ (record) -> Bool in
                    return record.isExpired == false
                }))
                
                self?.success.onNext(true)
            } else {
                self?.error.onNext(error!)
            }
        }
    }
}
