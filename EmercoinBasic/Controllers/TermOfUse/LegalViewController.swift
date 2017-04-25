//
//  TermOfUseViewController.swift
//  EmercoinBasic
//

import UIKit

class LegalViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override class func storyboardName() -> String {
        return "Legal"
    }
    
    override func back() {
        
        if parent is SideMenuViewController {
            backToDashBoard()
        } else {
            super.back()
        }
    }
}
