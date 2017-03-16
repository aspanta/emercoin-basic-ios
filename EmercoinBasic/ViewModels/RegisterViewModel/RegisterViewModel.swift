//
//  RegisterViewModel.swift
//  EmercoinOne
//

import UIKit
import RxSwift
import RxCocoa

class RegisterViewModel {

    var login:String = "" {didSet{validateCredentials()}}
    var password:String = "" {didSet{validateCredentials()}}
    var confirmPassword:String = "" {didSet{validateCredentials()}}
    var isChecked:Bool = false {didSet{validateCredentials()}}
    
    var topConstraint = PublishSubject<CGFloat>()
    var leftConstraint = PublishSubject<CGFloat>()
    var isValidCredentials = PublishSubject<Bool>()
    
    var isValid = false
    
    internal func validateCredentials() {
        
        let isEqualPasswords = password == confirmPassword
        
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
