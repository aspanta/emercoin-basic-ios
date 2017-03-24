//
//  MyAddressBook.swift
//  EmercoinBasic
//

import UIKit
import RxCocoa
import RxSwift

class MyAddressBook: AddressBook {
    
    func addressesArray() -> [String] {
        
        return contacts.map({$0.address})
    }
    
    override func load() {
        
        activityIndicator.onNext(true)
        
        APIManager.sharedInstance.loadMyAddresses {[weak self] (data, error) in
            
            self?.activityIndicator.onNext(false)
            
            if error == nil {
                guard let adresses = data as? [String] else {
                    return
                }
                var array:[Contact] = []
                
                for i in 0...adresses.count - 1 {
                    
                    let name = ""
                    
                    array.append(Contact(name: name, address: adresses[i]))
                }
                
                self?.removeAll()
                self?.add(contacts: array)
                
                self?.success.onNext(true)
            } else {
                self?.error.onNext(error!)
            }
        }
    }
    
    override func addNewMyAddress(at name:String) {
        
        activityIndicator.onNext(true)
        
        APIManager.sharedInstance.loadMyNewAddress {[weak self] (data, error) in
            self?.activityIndicator.onNext(false)
            
            if error == nil {
                guard let address = data as? String else {
                    return
                }
                
                self?.insert(contact: Contact(name: name, address: address), at: 0)
        
                self?.success.onNext(true)
            } else {
                self?.error.onNext(error!)
            }
            
        }
    }
}
