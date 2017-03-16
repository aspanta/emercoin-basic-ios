//
//  LivecoinBalancesViewController.swift
//  EmercoinOne
//

import UIKit

class LivecoinBalancesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet internal weak var tableView:UITableView!
    
    var balances:LCBalances = LCBalances()
    
    let sectionHeight:CGFloat = 57.0
    let sectionCount = 2
    
    internal var selectedRows:[IndexPath] = []

    override class func storyboardName() -> String {
        return "Livecoin"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.hideEmtyCells()
    }
    
    override func setupUI() {
        super.setupUI()
        
        let color = UIColor(hexString: Constants.Colors.Status.Livecoin)
        addStatusBarView(color: color)
    }
    
    internal func item(at indexPath:IndexPath) -> LCCurrency {
        
        if indexPath.section == 0 {
            return balances.currencies.currencies[indexPath.row]
        } else {
            return balances.coins.currencies[indexPath.row]
        }
    }
    
}
