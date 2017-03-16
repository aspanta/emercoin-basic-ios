//
//  PutOrderViewController.swift
//  EmercoinOne
//

import UIKit

enum OrderPutType {
    case sell
    case buy
    
    var description:String {
        var text = ""
        switch self {
        case .sell:text = "Sell EMC"
        case .buy:text = "Buy EMC"
        }
        return text
    }
}

class PutOrderViewController: UIViewController, IndicatorInfoProvider  {
    
    @IBOutlet internal weak var tableView:UITableView!
    @IBOutlet internal weak var titleLabel:UILabel!

    var orderPutType:OrderPutType = .buy
    
    var orders:[LCOrder] = []
    
    override class func storyboardName() -> String {
        return "Livecoin"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.baseSetup()
        
        setupUI()
        stubOrders()
    }
    
    private func setupUI() {
        
        titleLabel.text = orderPutType == .buy ? "Selling" : "Buying"
        
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: orderPutType.description)
    }
    
    internal func item(at indexPath:IndexPath) -> LCOrder {
        
        return orders[indexPath.row]
    }
    
    private func stubOrders() {
        
        let orders1 = LCOrders()
        orders1.stubOrders(date: "")
        orders1.stubOrders(date: "")
        orders1.stubOrders(date: "")
        
        orders = orders1.orders
    }
    
    @IBAction func addButtonPressed() {
        
        addPutOrderView()
        
    }

}
