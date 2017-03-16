//
//  FeedbackViewModel.swift
//  EmercoinOne
//

import UIKit
import RxSwift
import RxCocoa

class FeedbackViewModel {
    
    let disposeBag = DisposeBag()
    
    var email:String = "" {didSet{validateCredentials()}}
    var subject:String = "" {didSet{validateCredentials()}}
    var text:String = "" {
        didSet {
            isPlaceholderHiden.onNext(text.length > 0)
        }
    }
    
    var topConstraint = PublishSubject<CGFloat>()
    var isValidCredentials = PublishSubject<Bool>()
    var isPlaceholderHiden = PublishSubject<Bool>()
    
    
    private func validateCredentials() {
        
        let valid = isValidEmail(email: email) && subject.length > 0
        isValidCredentials.onNext(valid)
    }
}
