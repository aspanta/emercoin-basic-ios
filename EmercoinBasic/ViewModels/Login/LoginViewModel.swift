//
//  LoginViewModel.swift
//  EmercoinOne
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewModel {
    
    let disposeBag = DisposeBag()
    
    var login:String = "" {didSet{validateCredentials()}}
    var password:String = "" {didSet{validateCredentials()}}
    
    var topConstraint = PublishSubject<CGFloat>()
    var isValidCredentials = PublishSubject<Bool>()
    
    private func validateCredentials() {
        
        let valid = login.length > 0 && password.length > 0
        isValidCredentials.onNext(valid)
    }
    
    func prepareUI() {
        
        if isIphone5() {
            let value = Constants.Constraints.Login.Top.iphone5
            topConstraint.onNext(CGFloat(value))
        }
    }

}
