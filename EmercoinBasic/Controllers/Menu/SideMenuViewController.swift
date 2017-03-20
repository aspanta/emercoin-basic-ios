//
//  SideMenuViewController.swift
//  EmercoinOne
//

import UIKit
import LGSideMenuController

class SideMenuViewController: LGSideMenuController {
    
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
        
        menu.pressed = {(index,subIndex) in
            self.selectTabItem(at: index,subIndex: subIndex)
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
        
        if index == 8 {
            logout()
        } else if index == 3 && subIndex != -1 {
            checkRootController()
            mainTabBarController.showNVSBrowser(at: index,subIndex:subIndex)
        } else if index > 3 {
            showController(at: index, subIndex: subIndex)
        } else {
            checkRootController()
            mainTabBarController.showController(at: index)
        }
        
        self.hideLeftView(animated: true, completionHandler: nil)
    }
    
    private func checkRootController() {
        
        if rootViewController != mainTabBarController {
            DispatchQueue.main.async {
                self.rootViewController = self.mainTabBarController
            }
        }
    }
    
    private func showController(at index:Index, subIndex:Int) {
        
        var vc:UIViewController?
        
        switch index {
        case 4:
            vc = SettingsViewController.controller()
        case 5:
            vc = AboutViewController.controller()
        case 6:
            vc = FeedbackViewController.controller()
        case 7:
            if subIndex == 1 {
                vc = TermOfUseViewController.controller()
            } else {
                vc = PrivacyPolicyViewController.controller()
            }
        default:
            return
        }
        
        let navController = BaseNavigationController(rootViewController: vc!)
        self.rootViewController = navController
    }
    
    private func logout() {
        dismiss(animated: true, completion: nil)
    }
}

extension UIViewController {
    
    @IBAction func backToDashBoard() {
        
        Router.sharedInstance.sideMenu?.showDashBoard()
    }
}
