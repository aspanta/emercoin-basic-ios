//
//  LivecoinOrdersViewController.swift
//  EmercoinOne
//

import UIKit

enum OrdersMode {
    case my
    case history
    case putOrder
    
    var description:String {
        var text = ""
        switch self {
            case .my:text = "MY ORDERS"
            case .history:text = "MY TRADE HISTORY"
            case .putOrder:text = "PLACE ORDER"
        }
        return text
    }
    
}

class LivecoinOrdersViewController: ButtonBarPagerTabStripViewController {

    let mainColor:UIColor = UIColor(hexString: "7AAAD7")
    let backgroundColor = UIColor(hexString: "#EAEAEA")
    
    @IBOutlet internal var titleLabel:UILabel!
    
    var ordersMode:OrdersMode = .my

    override class func storyboardName() -> String {
        return "Livecoin"
    }
    
    override func viewDidLoad() {

        setupUI()
        
        super.viewDidLoad()
    }

    private func setupUI() {
        
        titleLabel.text = ordersMode.description
        
        let view = UIView.statusView()
        view.backgroundColor = UIColor(hexString: Constants.Colors.Status.Livecoin)
        self.view.addSubview(view)
        
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
        
        if ordersMode == .putOrder {
            return getPutOrderControllers()
        } else {
            return getOrdersControllers()
        }
        
    }
    
    private func getOrdersControllers() -> [UIViewController] {
        
        let vc1 = BaseOrdersViewController.controller() as! BaseOrdersViewController
        let vc2 = BaseOrdersViewController.controller() as! BaseOrdersViewController
        
        var orderType1:OrdersType = .coins
        var orderType2:OrdersType = .all
        
        if ordersMode == .history {
            orderType1 = .all
            orderType2 = .coins
        }
        
        vc1.ordersType = orderType1
        vc2.ordersType = orderType2
        vc1.ordersMode = ordersMode
        vc2.ordersMode = ordersMode
        
        return [vc1, vc2]
    }
    
    private func getPutOrderControllers() -> [UIViewController] {
        
        let vc1 = PutOrderViewController.controller() as! PutOrderViewController
        let vc2 = PutOrderViewController.controller() as! PutOrderViewController
        
        vc1.orderPutType = .buy
        vc2.orderPutType = .sell
        
        return [vc1, vc2]
    }
    
    @IBAction func back() {
        
        self.navigationController?.popViewController(animated: true)
       
    }

}
