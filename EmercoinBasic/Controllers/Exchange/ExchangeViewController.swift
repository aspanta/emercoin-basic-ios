//
//  ExhangeViewController.swift
//  EmercoinOne
//

import UIKit

class ExchangeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet internal weak var tableView:UITableView!
    
    var exchange = Exchange()

    override class func storyboardName() -> String {
        return "Exchange"
    }
    
    override func setupUI() {
        super.setupUI()
        
        statusBarView?.backgroundColor = UIColor(hexString: Constants.Colors.Status.Exchange)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exchange.stubCourses()
        setupTableView()
    }
    
    private func setupTableView() {
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(self.handleRefresh(sender:)), for: .valueChanged)
        tableView.baseSetup()
    }
    
    func handleRefresh(sender:UIRefreshControl) {
       
        sender.endRefreshing()
    }
}
