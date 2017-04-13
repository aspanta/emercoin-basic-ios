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
            
            if filterString.isEmpty {
                return realm.objects(Record.self)
            } else {
                
                return realm.objects(Record.self).filter("name contains[c] %@",filterString)
            }
        }
    }
    
    var filterString = ""
    
    
    let disposeBag = DisposeBag()
    var success = PublishSubject<Bool>()
    var successDelete = PublishSubject<Bool>()
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
        
        APIManager.sharedInstance.deleteName(at: [record.name] as AnyObject) {[weak self] (data, error) in
            self?.activityIndicator.onNext(false)
            if let error = error {
               self?.error.onNext(error)
            } else {
                self?.successDelete.onNext(true)
            }
        }
    }
    
    func removeAll() {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(records)
        }
    }

    func update(at data:[String:Any], index:Int) {
        let realm = try! Realm()
        try! realm.write {
            let record = records[index]
            record.address = (data["address"] as? String) ?? ""
            record.expiresIn = (data["expiresIn"] as? Int) ?? 0
            record.value = (data["value"] as? String) ?? ""
            record.name = (data["name"] as? String) ?? ""
            record.expiresInDays = (data["expiresInDays"] as? Int) ?? 0
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
                
                //self?.success.onNext(true)
            } else {
                self?.error.onNext(error!)
            }
        }
    }
}
