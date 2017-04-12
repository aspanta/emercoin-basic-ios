//
//  HomeViewController.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet internal weak var tableView:UITableView!
    @IBOutlet internal weak var lockButton:LockButton!
    
    private var wallet = AppManager.sharedInstance.wallet
    let disposeBag = DisposeBag()
    
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

        let coin = wallet.emercoin
        
        coins = [coin]
        setupTableView()
        setupRefreshControl()
        setupHome()
    }
    
    private func setupHome() {
        
        wallet.error.subscribe(onNext: {[weak self] (error) in
            self?.showErrorAlert(at: error)
        })
        .addDisposableTo(disposeBag)
        
        wallet.locked.subscribe(onNext: {[weak self] (locked) in
            self?.lockButton.isLocked = locked
        })
        .addDisposableTo(disposeBag)
        
        wallet.success.subscribe(onNext: {[weak self] (state) in
            self?.tableView.reload()
        })
        .addDisposableTo(disposeBag)
    }
    
    private func showErrorAlert(at error:NSError) {
        
        let alert = AlertsHelper.errorAlert(at: error)
        present(alert, animated: true, completion: nil)
    }
    
    private func setupTableView() {
        
        selectedRows.append(IndexPath(row: 0, section: 0))
        
        tableView.hideEmtyCells()
        tableView.allowsSelection = false
    }
    
    private func setupRefreshControl() {
        
        let refresh = UIRefreshControl()
        refresh.tintColor = UIColor(hexString: Constants.Colors.Status.Emercoin)
        refresh.addTarget(self, action: #selector(self.handleRefresh(sender:)), for: .valueChanged)
        tableView.refreshControl = refresh
        
        wallet.isActivityIndicator.subscribe(onNext:{ [weak self] state in
            
            if state == false {
                refresh.endRefreshing()
            }
        })
        .addDisposableTo(disposeBag)
    }
    
    internal func handleRefresh(sender:UIRefreshControl) {
        wallet.loadInfo()
    }
}
