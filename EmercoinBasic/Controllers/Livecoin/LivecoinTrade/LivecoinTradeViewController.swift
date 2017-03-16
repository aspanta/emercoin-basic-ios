//
//  LivecoinTradeViewController.swift
//  EmercoinOne
//

import UIKit

class LivecoinTradeViewController: ButtonBarPagerTabStripViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet internal weak var tableView:UITableView!
    
    private weak var statusView:UIView?
    
    let mainColor:UIColor = UIColor(hexString: "7AAAD7")
    let backgroundColor = UIColor(hexString: "#EAEAEA")

    override class func storyboardName() -> String {
        return "Livecoin"
    }
    
    override func viewDidLoad() {
        setupUI()
        
        super.viewDidLoad()
        tableView.baseSetup()
        
        Router.sharedInstance.isLiveCoinTradeController = true
    }
    
    private func setupUI() {
        
        let view = UIView.statusView()
        view.backgroundColor = UIColor(hexString: Constants.Colors.Status.Livecoin)
        self.view.addSubview(view)
        statusView = view
        
        settings.style.buttonBarBackgroundColor = backgroundColor
        settings.style.buttonBarItemBackgroundColor = backgroundColor
        settings.style.selectedBarBackgroundColor = mainColor
        settings.style.buttonBarItemFont = UIFont(name: "Roboto-Regular", size: 18)!
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        settings.style.buttonBarHeight = 57.0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray
            newCell?.label.textColor = self?.mainColor
        }

    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let m15 = TradeGraphViewController.controller() as! TradeGraphViewController
        let h1 = TradeGraphViewController.controller() as! TradeGraphViewController
        let d1 = TradeGraphViewController.controller() as! TradeGraphViewController

        m15.timeLine = .m15
        h1.timeLine = .h1
        d1.timeLine = .d1

        return [m15, h1, d1]
    }
    
    internal func showBalancesController() {
        
        let controller = LivecoinBalancesViewController.controller()
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    internal func showOrdersController(at ordersMode:OrdersMode) {
        
        let controller = LivecoinOrdersViewController.controller() as! LivecoinOrdersViewController
        controller.ordersMode = ordersMode
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        let isLandscape = UIDevice.current.orientation.isLandscape
        statusView?.isHidden = isLandscape
        
        viewControllers.forEach { (controller) in
            if controller is TradeGraphViewController {
                let vc = controller as! TradeGraphViewController
                vc.changeOrientation(at: isLandscape)
            }
        }
    }

    @IBAction func back() {
        
        let isLandscape = UIDevice.current.orientation.isLandscape
        
        if isLandscape {
         
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
    
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
        Router.sharedInstance.isLiveCoinTradeController = false
    }
}
