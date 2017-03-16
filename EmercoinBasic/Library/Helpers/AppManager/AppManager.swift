//
//  AppManager.swift
//  EmercoinOne
//

import UIKit

class AppManager {
    
    internal static let sharedInstance = AppManager()
    
    var wallet:Wallet = Wallet()
    var myAddressBook:MyAddressBook = MyAddressBook()
}
