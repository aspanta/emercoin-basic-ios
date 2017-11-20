//
//  BaseAlertController.swift
//  EmercoinBasic
//

import UIKit

class BaseAlertController: UIAlertController {

    var done:(() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    deinit {
        
        if done != nil {
            done!()
            done = nil
        }
        print("deinit - BaseAlertController")
    }
}
