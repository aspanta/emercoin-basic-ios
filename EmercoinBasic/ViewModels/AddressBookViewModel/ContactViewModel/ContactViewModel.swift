//
//  ContactViewModel.swift
//  EmercoinOne
//

import UIKit

class ContactViewModel {

    var name:String = ""
    var address:String = ""
    
    init(contact:Contact) {
        
        guard let name = contact.name else {
            return
        }
        self.name = name
        
        guard let address = contact.address else {
            return
        }
        self.address = address
    }
}
