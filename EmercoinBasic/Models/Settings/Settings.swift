//
//  Settings.swift
//  EmercoinBasic
//

import UIKit
import SwiftyUserDefaults

let key = "login_info"

class Settings {
    
    var loginInfo:[String:String]?
    
    func save() {
        Defaults.set(loginInfo, forKey: key)
    }
    
    func load() {
        if let data = Defaults.value(forKey: key) {
            loginInfo = data as? [String:String]
        }
    }
    
    func clear() {
        loginInfo = nil
        Defaults[key] = nil
    }

}
