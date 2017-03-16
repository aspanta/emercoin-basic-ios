//
//  LiveLoginViewModell.swift
//  EmercoinOne
//

import UIKit
import RxSwift
import RxCocoa

class LoginLiveViewModel {
    
    let disposeBag = DisposeBag()
    
    var apiKey:String = "" {didSet{validateCredentials()}}
    var secretKey:String = "" {didSet{validateCredentials()}}
    
    var topConstraint = PublishSubject<CGFloat>()
    var isValidCredentials = PublishSubject<Bool>()
    
    private func validateCredentials() {
        
        let valid = apiKey.length > 0 && secretKey.length > 0
        isValidCredentials.onNext(valid)
    }
    
    func prepareUI() {
        
        if isIphone5() {
            let value = Constants.Constraints.Login.Top.iphone5
            topConstraint.onNext(CGFloat(value))
        }
    }

}
