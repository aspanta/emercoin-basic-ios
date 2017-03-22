//
//  AddressBook.swift
//  EmercoinBasic
//

import UIKit

class AddressBook {
    
    private var contactsList:[Contact] = []
    
    var contacts:[Contact] {
        get {
            return contactsList
        }
    }
    
    func add(contact:Contact) {
        contactsList.append(contact)
    }
    
    func add(contacts:[Contact]) {
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
        
        let contact1 = Contact()
        contact1.name = "Test1"
        contact1.address = "ES7d2mE9wWuSp6sSJ7tdQAPMNxaLzh7rds"
        
        let contact2 = Contact()
        contact2.name = "Test2"
        contact2.address = "EcBxJTG7qJsdyuWT1TtftX7QQD47BD1CUw"
        
        let contact3 = Contact()
        contact3.name = "Test3"
        contact3.address = "ELRvYhiize7ktMAJmvL4JKvw4x7wtv4AyM"
        
        add(contact: contact1)
        add(contact: contact2)
        add(contact: contact3)
        
    }
    
}
