//
//  Utils.swift
//  EmercoinBasic
//

import UIKit

public func loadViewFromXib(name:String, index:Int, frame:CGRect? = nil) -> UIView {
    let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)![index] as! UIView
    
    if frame != nil {
        view.frame = frame!
    }
    return view
}

public func isIphone5() -> Bool {
    
    var result:Bool! = false
    
    if screenSize().height == 568 {
        result = true
    }
    
    return result
}

internal func screenSize() -> CGRect {
    return UIScreen.main.bounds
}

public func isValidEmail(email:String?) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    let result = emailTest.evaluate(with: email)
    return result
}
