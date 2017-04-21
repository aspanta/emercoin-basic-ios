//
//  TermOfUseViewController.swift
//  EmercoinBasic
//

import UIKit

class TermOfUseViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override class func storyboardName() -> String {
        return "TermOfUse"
    }
    
    override func back() {
        
        if parent is SideMenuViewController {
            backToDashBoard()
        } else {
            super.back()
        }
    }
}
