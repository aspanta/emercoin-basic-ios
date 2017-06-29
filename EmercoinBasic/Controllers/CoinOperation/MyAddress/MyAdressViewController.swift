//
//  MyAdressViewController.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

class MyAdressViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet internal weak var tableView:UITableView!
    
    var addressBook = AddressBook()
    var isMyAddressBook = true
    let disposeBag = DisposeBag()
    
    override class func storyboardName() -> String {
        return "CoinOperations"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isMyAddressBook {
            addressBook = AppManager.sharedInstance.myAddressBook
            setupAddresses()
            setupActivityIndicator()
            setupRefreshControl()
            addressBook.load()
        }
        
        tableView.baseSetup()
        hideStatusBar()
    }
    
    private func setupAddresses() {
        
        addressBook.success.subscribe(onNext:{ [weak self] success in
            if success {self?.tableView.reload()}
        }).addDisposableTo(disposeBag)
        
        addressBook.error.subscribe(onNext:{ [weak self] error in
            self?.hideOperationActivityView()
            self?.showErrorAlert(at: error)
        }).addDisposableTo(disposeBag)
    }
    
    private func setupActivityIndicator() {
        
        addressBook.activityIndicator.subscribe(onNext:{ [weak self] state in
            
            let refresh = self?.tableView.refreshControl
            
            if state == false {
                if refresh?.isRefreshing == true  {
                    refresh?.endRefreshing()
                }
                self?.hideOperationActivityView()
            }
        }).addDisposableTo(disposeBag)
    }
    
    private func setupRefreshControl() {
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.handleRefresh(sender:)), for: .valueChanged)
        tableView.refreshControl = refresh
    }
    
    internal func handleRefresh(sender:UIRefreshControl) {
        addressBook.load(loadAll: true)
    }

    func showAddAddressView() {
        
        let addAddressView = loadViewFromXib(name: "AddressBook", index: 2,
                                             frame: self.parent!.view.frame) as! AddAddressView
        addAddressView.add = ({[weak self] (name) in
            self?.addressBook.addNewMyAddress(at: name)
            self?.showOperationActivityView()
        })
        
        self.parent?.view.addSubview(addAddressView)
    }
    
    override func showOperationActivityView() {
        
        var controller:UIViewController?
        
        if let parent = self.parent as? CoinOperationsViewController {
            controller = parent
        }
        
        if let controller = controller {
            let view = getOperationView(at: 2)
            self.operationActivityView = view
            userInteraction(at: false)
            controller.view.addSubview(view)
        }
    }
}
