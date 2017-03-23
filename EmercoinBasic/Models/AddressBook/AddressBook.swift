//
//  AddressBook.swift
//  EmercoinBasic
//

import UIKit
import RxCocoa
import RxSwift

class AddressBook {
    
    private var contactsList:[Contact] = []
    
    var contacts:[Contact] {
        get {
            return contactsList
        }
    }
    
    let disposeBag = DisposeBag()
    var success = PublishSubject<Bool>()
    var error = PublishSubject<Error>()
    var activityIndicator = PublishSubject<Bool>()
    
    func add(contact:Contact) {
        contactsList.append(contact)
    }
    
    func add(contacts:[Contact]) {
        contactsList.append(contentsOf: contacts)
    }
    
    func add(contact:[Contact]) {
        contacts.forEach { (contact) in
            add(contact: contact)
        }
    }
    
    func remove(contact:Contact) {
        contactsList.remove(object: contact)
    }
    
    func removeAll() {
        contactsList.removeAll()
    }
    
    func stubContacts() {
        
        let contact1 = Contact(name: "Test1", address: "ES7d2mE9wWuSp6sSJ7tdQAPMNxaLzh7rds")
        let contact2 = Contact(name: "Test2", address: "EcBxJTG7qJsdyuWT1TtftX7QQD47BD1CUw")
        let contact3 = Contact(name: "Test3", address: "ELRvYhiize7ktMAJmvL4JKvw4x7wtv4AyM")
        
        add(contact: contact1)
        add(contact: contact2)
        add(contact: contact3)
        
    }
    
    func load() {
        
    }
    
}
