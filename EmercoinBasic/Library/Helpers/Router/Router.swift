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
        if let window = UIApplication.shared.delegate?.window {
            UIView.transition(with: window!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window?.rootViewController = viewController
            }, completion: nil)
        }
    }
    
    internal func showLoginController() {
        let login = controller(at: "login")
        changeRootController(to:login)
        sideMenu = nil
    }
    
    internal func showMainController() {
        let main = controller(at: "main")
        changeRootController(to:main)
    }
    
    func initialController() -> UIViewController {
        
        var name = "login"
        
        if let authInfo = AppManager.sharedInstance.settings.authInfo {
            APIManager.sharedInstance.addAuthInfo(at: authInfo)
            name = "main"
        }
        
        return controller(at: name)
    }
    
    private func controller(at name:String) -> UIViewController {
        
        var controller = UIViewController()
        
        switch name {
        case "main":
            let main = UIStoryboard(name: "Main", bundle: nil)
            controller = main.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        case "login":controller = LoginViewController.controller()
        default:
            break
        }
        let nav = BaseNavigationController(rootViewController: controller)
        return nav
    }
    
}
