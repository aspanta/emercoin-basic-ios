//
//  PrivacyPolicyViewController.swift
//  EmercoinBasic
//

import UIKit

class PrivacyPolicyViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override class func storyboardName() -> String {
        return "PrivacyPolicy"
    }
    
    override func back() {
        
        if parent is SideMenuViewController {
            backToDashBoard()
        } else {
            super.back()
        }
    }
    
}
