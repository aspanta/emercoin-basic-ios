//
//  LoginViewModel.swift
//  EmercoinOne
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewModel {
    
    var host:String = "" {didSet{validateCredentials()}}
    var port:String = "" {didSet{validateCredentials()}}
    var `protocol`:String = "" {didSet{validateCredentials()}}
    
    var login:String = "" {didSet{validateCredentials()}}
    var password:String = "" {didSet{validateCredentials()}}
    var confirmPassword:String = "" {didSet{validateCredentials()}}
    var isChecked:Bool = false {didSet{validateCredentials()}}
    
    var topConstraint = PublishSubject<CGFloat>()
    var leftConstraint = PublishSubject<CGFloat>()
    var isValidCredentials = PublishSubject<Bool>()
    
    var isValid = false
    
    func validateCredentials() {
        
        let isEqualPasswords = password == confirmPassword
        
        let valid = isValid && (host.length > 0 && port.length > 0 && `protocol`.length > 0)
        
        isValidCredentials.onNext(valid)
        
        isValid = login.length > 0 && password.length > 0 && isEqualPasswords && isChecked
        isValidCredentials.onNext(isValid)
    }
    
    func prepareUI() {
        
        if isIphone5() {
            let value = Constants.Constraints.Login.Top.iphone5
            topConstraint.onNext(CGFloat(value))
            leftConstraint.onNext(CGFloat(value))
        }
    }
}
