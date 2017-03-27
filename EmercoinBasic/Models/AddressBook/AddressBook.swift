//
//  AddressBook.swift
//  EmercoinBasic
//

import UIKit
import RxCocoa
import RxSwift
import RealmSwift

class AddressBook {
    
    var contacts:Results<Contact> {
        get {
            let realm = try! Realm()
            return realm.objects(Contact.self).filter("isMyContact == false")
        }
    }
    
    let disposeBag = DisposeBag()
    var success = PublishSubject<Bool>()
    var error = PublishSubject<NSError>()
    var activityIndicator = PublishSubject<Bool>()
    
    func add(contact:Contact) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(contact)
        }
    }
    
    func add(contacts:[Contact]) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(contacts)
        }
    }
    
    func remove(contact:Contact) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(contact)
        }
    }
    
    func remove(contacts:[Contact]) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(contacts)
        }
    }
    
    func stubContacts() {
        
        if contacts.count == 0 {
            
            let contact1 = Contact(value: ["name":"Test1","address":"ES7d2mE9wWuSp6sSJ7tdQAPMNxaLzh7rds"])
            let contact2 = Contact(value: ["name":"Test2","address":"EcBxJTG7qJsdyuWT1TtftX7QQD47BD1CUw"])
            let contact3 = Contact(value: ["name":"Test3","address":"ELRvYhiize7ktMAJmvL4JKvw4x7wtv4AyM"])
            
            add(contacts: [contact1, contact2, contact3])
        }
    }
    
    func load() {
        
    }
    
    func addNewMyAddress(at name:String) {
    
    }
}
