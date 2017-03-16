//
//  TabBarController.swift
//  EmercoinOne
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        addControllers()
    }
    
    var subControllerIndex = -1
    
    func showNVSBrowser(at subIndex:Int) {
        
        
        guard let nav = viewControllers?.last as? BaseNavigationController else {
            return
        }
        
        guard let vc = nav.viewControllers.first as? BlockchainViewController else {
            return
        }
        
        if nav.viewControllers.count > 1 {
            nav.popToRootViewController(animated: false)
        }
        
        if selectedIndex == 4 {
            vc.showBrowserSubController(at: subIndex)
        } else {
            subControllerIndex = subIndex
            selectedIndex = 4
        }
    }

    private func setupUI() {
        
        tabBar.tintColor = UIColor(hexString: Constants.Colors.TabBar.Tint)
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSFontAttributeName:UIFont(name: "RobotoCondensed-Bold", size: 10)]
        appearance.setTitleTextAttributes(attributes, for: .normal)
        
        appearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
        
    }
    
    private func addControllers() {
        
        let home = HomeViewController.controller() as! BaseViewController
        let homeNav = BaseNavigationController(rootViewController: home)
        let send = CoinsOperationViewController.controller() as! CoinsOperationViewController
        let sendNav = BaseNavigationController(rootViewController: send)
        let get = CoinsOperationViewController.controller() as! CoinsOperationViewController
        let getNav = BaseNavigationController(rootViewController: get)
        let exchange = ExchangeViewController.controller() as! BaseViewController
        let exchangeNav = BaseNavigationController(rootViewController: exchange)
        let blockChain = BlockchainViewController.controller() as! BlockchainViewController
        let blockChainNav = BaseNavigationController(rootViewController: blockChain)
        
        
        send.tabBarObject = TabBarObject(title: Constants.Controllers.TabTitle.Send,
                                        imageName: Constants.Controllers.TabImage.Send)
        send.coinsOperation = .recipientAddress
        
        get.tabBarObject = TabBarObject(title: Constants.Controllers.TabTitle.Get,
                                         imageName: Constants.Controllers.TabImage.Get)
        get.coinsOperation = .get
        
        exchange.tabBarObject = TabBarObject(title: Constants.Controllers.TabTitle.Exchange,
                                         imageName: Constants.Controllers.TabImage.Exchange)
        
        blockChain.tabBarObject = TabBarObject(title: Constants.Controllers.TabTitle.BlockChain,
                                         imageName: Constants.Controllers.TabImage.BlockChain)
        
        blockChain.viewDidAppear = {
            
            if self.subControllerIndex != -1 {
                blockChain.showBrowserSubController(at: self.subControllerIndex)
                self.subControllerIndex = -1
            }
        }

        viewControllers = [homeNav,sendNav,getNav,exchangeNav,blockChainNav]
        
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
