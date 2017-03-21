//
//  TabBarController.swift
//  EmercoinBasic
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        addControllers()
    }
    
    var subControllerIndex = -1
    
    private func setupUI() {
        
        tabBar.tintColor = UIColor(hexString: Constants.Colors.TabBar.Tint)
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSFontAttributeName:UIFont(name: "RobotoCondensed-Bold", size: 10)]
        appearance.setTitleTextAttributes(attributes, for: .normal)
        
        appearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
        
    }
    
    func showController(at index:Int) {
        
        checkChildControllers(at: index)
        
        selectedIndex = index
    }
    
    func showNVSBrowser(at index:Int, subIndex:Int) {
        
        
        guard let nav = viewControllers?.last as? BaseNavigationController else {
            return
        }
        
        guard let vc = nav.viewControllers.first as? BlockchainViewController else {
            return
        }
        
        checkChildControllers(at: index)
        
        if selectedIndex == index {
            vc.showBrowserSubController(at: subIndex)
        } else {
            subControllerIndex = subIndex
            selectedIndex = index
        }
    }
    
    private func checkChildControllers(at index:Int) {
        
        guard let nav = viewControllers?[index] as? BaseNavigationController else {
            return
        }
        
        if nav.viewControllers.count > 1 {
            nav.popToRootViewController(animated: false)
        }
    }
    
    internal override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item.description)
        
        guard let index = tabBar.items?.index(of: item) else {
            return
        }
        
        checkChildControllers(at: index)
    }
    
    private func addControllers() {
        
        let home = HomeViewController.controller() as! BaseViewController
        let homeNav = BaseNavigationController(rootViewController: home)
        let send = CoinOperationsViewController.controller() as! CoinOperationsViewController
        let sendNav = BaseNavigationController(rootViewController: send)
        let get = CoinOperationsViewController.controller() as! CoinOperationsViewController
        let getNav = BaseNavigationController(rootViewController: get)
        let blockChain = BlockchainViewController.controller() as! BlockchainViewController
        let blockChainNav = BaseNavigationController(rootViewController: blockChain)
        
        
        send.tabBarObject = TabBarObject(title: Constants.Controllers.TabTitle.Send,
                                        imageName: Constants.Controllers.TabImage.Send)
        send.coinsOperation = .recipientAddress
        
        get.tabBarObject = TabBarObject(title: Constants.Controllers.TabTitle.Get,
                                         imageName: Constants.Controllers.TabImage.Get)
        get.coinsOperation = .get
        
        blockChain.tabBarObject = TabBarObject(title: Constants.Controllers.TabTitle.BlockChain,
                                         imageName: Constants.Controllers.TabImage.BlockChain)
        
        blockChain.viewDidAppear = {
            
            if self.subControllerIndex != -1 {
                blockChain.showBrowserSubController(at: self.subControllerIndex)
                self.subControllerIndex = -1
            }
        }

        viewControllers = [homeNav,sendNav,getNav,blockChainNav]
        
        let count:Int = (viewControllers?.count)!
        
        for index in 0...count - 1 {
            
            let tabHome = tabBar.items?[index]
            
            let navVC = viewControllers?[index] as! UINavigationController
            guard let vc = navVC.viewControllers.first as? TabBarObjectInfo else {
                break
            }
            
            if let item = vc.tabBarObject {
                tabHome?.title = item.title
                tabHome?.image = UIImage(named:item.imageName)
            }
        }
    }

}
