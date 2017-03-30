//
//  SideMenuViewController.swift
//  EmercoinBasic
//

import UIKit
import LGSideMenuController

class SideMenuViewController: LGSideMenuController {
    
    var logout:((Void) -> (Void))?
    
    fileprivate var mainTabBarController:TabBarController = {
        TabBarController.controller()
    }() as! TabBarController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMenu()
    }
    
    private func setupMenu() {
        
        let menu = LeftViewController.controller() as! LeftViewController
        rootViewController = mainTabBarController
        
        menu.pressed = {[weak self](index,subIndex) in
            self?.selectTabItem(at: index,subIndex: subIndex)
        }
        
        menu.width = self.leftViewWidth
        
        leftViewController = menu
        
        Router.sharedInstance.sideMenu = self
        
        leftViewSwipeGestureRange = LGSideMenuSwipeGestureRangeMake(100.0, 100.0)
    }
    
    func showDashBoard() {
        selectTabItem(at: 0, subIndex:0)
    }
    
    private func selectTabItem(at index:Int, subIndex:Int) {
        
        if index == 9 {
            self.performLogout()
        } else if index == 4 && subIndex != -1 {
            self.checkRootController()
            self.mainTabBarController.showNVSBrowser(at: index,subIndex:subIndex)
        } else if index > 4 {
            self.showController(at: index, subIndex: subIndex)
        } else {
            self.checkRootController()
            self.mainTabBarController.showController(at: index)
        }
        
        DispatchQueue.main.async {
            self.hideLeftView(animated: true)
        }
    }
    
    deinit {
        print("deinit - SideMenuViewController")
    }
    
    private func checkRootController() {
        
        if rootViewController != mainTabBarController {
            DispatchQueue.main.async {
                self.changeRootController(to: self.mainTabBarController)
            }
        }
    }
    
    private func showController(at index:Index, subIndex:Int) {
        
        var vc:UIViewController?
        
        switch index {
        case 5:
            let bookVC = AddressBookViewController.controller() as! AddressBookViewController
            bookVC.isFromMenu = true
            vc = bookVC
        case 6:vc = AboutViewController.controller()
        case 7:vc = PrivacyPolicyViewController.controller()
        case 8:vc = TermOfUseViewController.controller()
        default:
            return
        }
        
        //let navController = BaseNavigationController(rootViewController: vc!)
        //self.rootViewController = navController
        
        changeRootController(to: vc!)
    }
    
    private func changeRootController(to controller:UIViewController)  {
        
        UIView.transition(with: self.rootView!, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.rootViewController = controller
        }, completion: nil)
    }
    
    func performLogout() {
        
        if logout != nil {
            logout!()
        }
        
        AppManager.sharedInstance.logOut()
        Router.sharedInstance.showLoginController()
    }
}

extension UIViewController {
    
    @IBAction func backToDashBoard() {
        
        Router.sharedInstance.sideMenu?.showDashBoard()
    }
}
