//
//  BaseOrdersViewController.swift
//  EmercoinOne
//

import UIKit

enum OrdersType {
    case coins
    case all
    
    var description:String {
    
        var text = ""
        
        switch self {
        case .all:
            text = "All orders"
        case .coins:
            text = "EMC/BTC"
        }
        return text
    }
}

class BaseOrdersViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet internal weak var tableView:UITableView!
    
    var orderSections:[LCOrders] = []
    var ordersMode:OrdersMode = .my
    
    let sectionHeight:CGFloat = 30.0

    override class func storyboardName() -> String {
        return "Livecoin"
    }
    
    var ordersType:OrdersType = .coins
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tableView.baseSetup()
        
        stubOrders()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: ordersType.description)
    }
    
    internal func item(at indexPath:IndexPath) -> LCOrder {
        
        return orderSections[indexPath.section].orders[indexPath.row]
    }
    
    private func stubOrders() {
        
        let orders1 = LCOrders()
        orders1.stubOrders(date: "21.10.2016")
        
        let orders2 = LCOrders()
        orders2.stubOrders(date: "19.10.2016")
        
        let orders3 = LCOrders()
        orders3.stubOrders(date: "17.10.2016")
        
        orderSections = [orders1, orders2, orders3]
    }

}
