//
//  Router.swift
//  EmercoinBasic
//

import Foundation
import UIKit

class Router {
    
    internal static let sharedInstance = Router()
    internal var sideMenu:SideMenuViewController?
    
    private func changeRootController(to viewController: UIViewController) {
        viewController.view.layoutSubviews()
        if let window = UIApplication.shared.delegate?.window {
            UIView.transition(with: window!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window?.rootViewController = viewController
            }, completion: nil)
        }
    }
    
    internal func showLoginController() {
        let login = LoginViewController.controller()
        let nav = BaseNavigationController(rootViewController: login)
        changeRootController(to:nav)
        sideMenu = nil
    }
    
    internal func showMainController() {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let controller = main.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        //let nav = BaseNavigationController(rootViewController: controller)
        
        AppManager.sharedInstance.isAuthorized = true
        
        changeRootController(to:controller)
    }
    
}
