//
//  BaseNavigationController.swift
//  EmercoinOne
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isHidden = true
    }
    
    override var shouldAutorotate: Bool {
        
        if Router.sharedInstance.isLiveCoinTradeController {
            return true
        }
        return false
    }
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .all
    }
}
