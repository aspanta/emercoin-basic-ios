//
//  HistoryViewController.swift
//  EmercoinOne
//

import UIKit

class HistoryViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet internal weak var tableView:UITableView!
    
    var history = History()
    
    override class func storyboardName() -> String {
        return "AccountPage"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        history.stubContacts()
        tableView.baseSetup()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "History")
    }
}
