//
//  EnterServerViewModelView.swift
//  EmercoinOne
//

import UIKit

class EnterServerViewModelView: RegisterViewModel {
    
    var host:String = "" {didSet{validateCredentials()}}
    var port:String = "" {didSet{validateCredentials()}}
    var `protocol`:String = "" {didSet{validateCredentials()}}
    
    override func validateCredentials() {
        super.validateCredentials()
        
        let valid = isValid && (host.length > 0 && port.length > 0 && `protocol`.length > 0)
        
        isValidCredentials.onNext(valid)
    }
    
    override init() {
        super.init()
        
        
    }
}
