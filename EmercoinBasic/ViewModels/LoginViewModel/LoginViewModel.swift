//
//  LoginViewModel.swift
//  EmercoinBasic
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewModel {
    
    var host:String = "" {didSet{validateCredentials()}}
    var port:String = "" {didSet{validateCredentials()}}
    var webProtocol:String = "" {didSet{validateCredentials()}}
    
    var login:String = "" {didSet{validateCredentials()}}
    var password:String = "" {didSet{validateCredentials()}}
    var isChecked:Bool = false {didSet{validateCredentials()}}
    
    var topConstraint = PublishSubject<CGFloat>()
    var leftConstraint = PublishSubject<CGFloat>()
    var isValidCredentials = PublishSubject<Bool>()
    var isSuccessLogin = PublishSubject<Bool>()
    var isError = PublishSubject<Error>()
    var isActivityIndicator = PublishSubject<Bool>()
    
    var hostString = PublishSubject<String>()
    var portString = PublishSubject<String>()
    var loginString = PublishSubject<String>()
    var passwordString = PublishSubject<String>()
    var protocolString = PublishSubject<String>()

    var isLoading = false
    var isValid = false
    var isAutoLogin = false
    
    private var settings = AppManager.sharedInstance.settings
    
    func validateCredentials() {
        
        let valid = isValid && (host.length > 0 && port.length > 0 && webProtocol.length > 0)
        
        isValidCredentials.onNext(valid)
        
        isValid = login.length > 0 && password.length > 0 && isChecked
        isValidCredentials.onNext(isValid)
    }
    
    func prepareUI() {
        
        if isIphone5() {
            let value = Constants.Constraints.Login.Top.iphone5
            topConstraint.onNext(CGFloat(value))
            leftConstraint.onNext(CGFloat(value))
        }
        
        if isAutoLogin {
            hostString.onNext(host)
            portString.onNext(port)
            loginString.onNext(login)
            passwordString.onNext(password)
            protocolString.onNext(webProtocol)
        }
    }
    
    init() {
        
        if let loginInfo = settings.loginInfo {
            host = loginInfo["host"] ?? ""
            port = loginInfo["port"] ?? ""
            login = loginInfo["user"] ?? ""
            password = loginInfo["password"] ?? ""
            webProtocol = loginInfo["protocol"] ?? ""
            isAutoLogin = true
        }
        
    }
    
    func performLogin() {
        
        if isLoading {return}
        
        var loginInfo = [String:String]()
        
        loginInfo["host"] = host
        loginInfo["port"] = port
        loginInfo["user"] = login
        loginInfo["password"] = password
        loginInfo["protocol"] = webProtocol
        
        isActivityIndicator.onNext(true)
        isLoading = true
        
        APIManager.sharedInstance.login(at: loginInfo) {[weak self] (data, error) in
            self?.isLoading = false
            self?.isActivityIndicator.onNext(false)
            if error != nil {
                self?.isError.onNext(error!)
            } else {
                
                if self?.settings.loginInfo == nil {
                    self?.settings.loginInfo = loginInfo
                    self?.settings.save()
                }
                
                if let wallet = data as? Wallet {
                    AppManager.sharedInstance.wallet = wallet
                    AppManager.sharedInstance.myAddressBook.load()
                }
                self?.isSuccessLogin.onNext(true)
            }
        }
    }
}
