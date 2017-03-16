//
//  AddressBook.swift
//  EmercoinOne
//

import UIKit

class AddressBook {
    
    private var contactsList:[Contact] = []
    
    var cointType:CoinType?
    
    var contacts:[Contact] {
        get {
            return contactsList.filter { (contact) -> Bool in
                return contact.coinType == self.cointType
            }
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
        contact1.name = "Evgen"
        contact1.address = "1YhdkU125423kdf58RtEb6"
        contact1.coinType = .bitcoin
        
        let contact2 = Contact()
        contact2.name = "Marija"
        contact2.address = "1YhdkU125423kdf58RtEb6"
        contact2.coinType = .bitcoin
        
        let contact3 = Contact()
        contact3.name = "Mark"
        contact3.address = "1YhdkU125423kdf58RtEb6"
        contact3.coinType = .emercoin
        
        let contact4 = Contact()
        contact4.name = "Dzhon"
        contact4.address = "1YhdkU125423kdf58RtEb6"
        contact4.coinType = .emercoin
        
        add(contact: contact1)
        add(contact: contact2)
        add(contact: contact3)
        add(contact: contact4)
        
    }
    
}
