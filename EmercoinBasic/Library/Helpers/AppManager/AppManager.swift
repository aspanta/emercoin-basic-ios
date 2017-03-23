//
//  AppManager.swift
//  EmercoinBasic
//

import UIKit

class AppManager {
    
    internal static let sharedInstance = AppManager()
    
    var wallet:Wallet?
    var myAddressBook:MyAddressBook = MyAddressBook()
    var settings:Settings = {
        let settings = Settings()
        settings.load()
        return settings
    }()
    
    func logOut() {
        
        settings.clear()
    }
    
}
