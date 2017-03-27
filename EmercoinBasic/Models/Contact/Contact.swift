//
//  Contact.swift
//  EmercoinBasic
//

import UIKit
import RealmSwift

class Contact: Object {
    
    dynamic var name = ""
    dynamic var address = ""
    dynamic var isMyContact = false
    
    func update(at name:String) {
        
        let realm = try! Realm()
        try! realm.write {
            self.name = name
        }
    }
    
}
