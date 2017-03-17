//
//  MyAddressBook.swift
//  EmercoinOne
//
//  Created by Sergey Lyubeznov on 21/02/2017.
//  Copyright © 2017 Aspanta. All rights reserved.
//

import UIKit

class MyAddressBook: AddressBook {
    
    override init() {
        super.init()
        stubContacts()
    }
    
    override func stubContacts() {
        
        let contact1 = Contact()
        contact1.name = "Primary"
        contact1.address = String.randomStringWithLength(20)
        
        let contact2 = Contact()
        contact2.name = "Payer 1"
        contact2.address = String.randomStringWithLength(20)
        
        let contact3 = Contact()
        contact3.name = "Payer 2"
        contact3.address = String.randomStringWithLength(20)
        
        let contact4 = Contact()
        contact4.name = "Payer 3"
        contact4.address = String.randomStringWithLength(20)
        
        let contact5 = Contact()
        contact5.name = "Payer 4"
        contact5.address = String.randomStringWithLength(20)
        
        let contact6 = Contact()
        contact6.name = "Payer 5"
        contact6.address = String.randomStringWithLength(20)
        
        let contact7 = Contact()
        contact7.name = "Payer 6"
        contact7.address = String.randomStringWithLength(20)
        
        let contact8 = Contact()
        contact8.name = "Payer 7"
        contact8.address = String.randomStringWithLength(20)
        
        add(contact: contact1)
        add(contact: contact2)
        add(contact: contact3)
        add(contact: contact4)
        add(contact: contact5)
        add(contact: contact6)
        add(contact: contact7)
        add(contact: contact8)
    }
    
    func addressesArray() -> [String] {
        var array:[String] = []
        
        contacts.forEach { (contact) in
            array.append(contact.address!)
        }
        
        return array
    }
}
