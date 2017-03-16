//
//  HistoryViewController.swift
//  EmercoinOne
//

import UIKit

class HistoryViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet internal weak var tableView:UITableView!
    
    var history = History()
    
    var coinType:CoinType = .bitcoin

    override class func storyboardName() -> String {
        return "AccountPage"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        history.stubContacts(cointType: .bitcoin)
        history.stubContacts(cointType: .emercoin)
        
        history.cointType = coinType
        
        tableView.baseSetup()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "History")
    }
}
