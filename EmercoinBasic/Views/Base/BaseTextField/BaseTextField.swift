//
//  BaseTextField.swift
//  EmercoinOne
//

import UIKit
import RxSwift
import RxCocoa

class BaseTextField: UITextField, UITextFieldDelegate {
    
    @IBInspectable var maxCharacters: Int = 0
    @IBInspectable var disableEdit: Bool = false

    var done:((_ text:String) -> (Void))?
    var textChanged:((_ text:String) -> (Void))?
    
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        
        delegate = self
        
        self.rx.controlEvent([.editingChanged])
            .asObservable()
            .subscribe(onNext: {(_) in
                if self.textChanged != nil {
                    self.textChanged!((self.text)!)
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        .addDisposableTo(disposeBag)
    }
    
    override func resignFirstResponder() -> Bool {
        if done != nil {
            done!(self.text!)
        }
        
        return super.resignFirstResponder()
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if disableEdit {
            return false
        }
        
        let text = textField.text!
        
        let fullText = text+string
        
        if maxCharacters == 0 {
            return true
        } else {
             return  fullText.length <= maxCharacters
        }
    }
    
}
