//
//  Contact.swift
//  EmercoinBasic
//

import UIKit

class Contact: NSObject {
    
    var name:String
    var address:String
    var date = Date()
    
    init(name:String, address:String) {
        self.name = name
        self.address = address
    }
    
}
