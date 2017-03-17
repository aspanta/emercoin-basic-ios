//
//  HomeViewController.swift
//  EmercoinOne
//

import UIKit

final class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet internal weak var tableView:UITableView!
    
    internal var selectedRows:[IndexPath] = []
    internal var coins:[Any] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarObject = TabBarObject.init(title: Constants.Controllers.TabTitle.Home,
                                         imageName: Constants.Controllers.TabImage.Home)
    }
    
    override class func storyboardName() -> String {
        return "Home"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let wallet = AppManager.sharedInstance.wallet
        
        coins = [wallet.emercoin]
        setupTableView()
    }
    
    private func setupTableView() {
        
        tableView.hideEmtyCells()
        tableView.allowsSelection = false
    }

}
