//
//  HomeViewController.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet internal weak var tableView:UITableView!
    
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

        guard let coin = wallet?.emercoin else {
            return
        }
        
        coins = [coin]
        setupTableView()
        setupRefreshControl()
        setupHome()
    }
    
    private func setupHome() {
        
        wallet?.error.subscribe(onNext: {[weak self] (error) in
            self?.showErrorAlert(at: error)
        })
        .addDisposableTo(disposeBag)
        
        wallet?.success.subscribe(onNext: {[weak self] (state) in
            self?.tableView.reload()
        })
        .addDisposableTo(disposeBag)
    }
    
    private func showErrorAlert(at error:Error) {
        
        let alert = UIAlertController(
            title: "Error",
            message: String (format:error.localizedDescription),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
        print(error.localizedDescription)
    }
    
    private func setupTableView() {
        
        tableView.hideEmtyCells()
        tableView.allowsSelection = false
    }
    
    private func setupRefreshControl() {
        
        let refresh = UIRefreshControl()
        refresh.tintColor = UIColor(hexString: Constants.Colors.Status.Emercoin)
        refresh.addTarget(self, action: #selector(self.handleRefresh(sender:)), for: .valueChanged)
        tableView.refreshControl = refresh
        
        wallet?.isActivityIndicator.subscribe(onNext:{ [weak self] state in
            
            if state == false {
                refresh.endRefreshing()
            }
        })
        .addDisposableTo(disposeBag)
    }
    
    internal func handleRefresh(sender:UIRefreshControl) {
        wallet?.loadBalance()
    }

}