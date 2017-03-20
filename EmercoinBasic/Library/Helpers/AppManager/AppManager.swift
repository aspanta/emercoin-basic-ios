//
//  AppManager.swift
//  EmercoinOne
//

import UIKit

class AppManager {
    
    internal static let sharedInstance = AppManager()
    
    var wallet:Wallet?
    var myAddressBook:MyAddressBook = MyAddressBook()
    
    
}
