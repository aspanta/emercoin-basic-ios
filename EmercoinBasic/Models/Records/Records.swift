//
//  BCNotes.swift
//  EmercoinBasic
//

import UIKit
import RxCocoa
import RxSwift
import RealmSwift

class Records: NSObject {
    
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
                self?.add(records: records)
                
                self?.success.onNext(true)
            } else {
                self?.error.onNext(error!)
            }
        }
    }
}
