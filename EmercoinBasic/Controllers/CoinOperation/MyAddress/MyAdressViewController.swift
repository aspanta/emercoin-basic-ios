//
//  MyAdressViewController.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

class MyAdressViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet internal weak var tableView:UITableView!
    @IBOutlet internal weak var activityView:UIActivityIndicatorView!
    
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
            
            if addressBook.contacts.count == 0 {
                addressBook.load()
            } else {
                setupRefreshControl()
            }
        }
        
        tableView.baseSetup()
        hideStatusBar()
    }
    
    private func setupAddresses() {
        
        addressBook.success.subscribe(onNext:{ [weak self] success in
            if success {self?.tableView.reload()}
        })
            .addDisposableTo(disposeBag)
        
        addressBook.error.subscribe(onNext:{ [weak self] error in
            self?.showErrorAlert(at: error)
        })
            .addDisposableTo(disposeBag)
    }
    
    private func setupActivityIndicator() {
        
        addressBook.activityIndicator.subscribe(onNext:{ [weak self] state in
            
            let refresh = self?.tableView.refreshControl
            
            if refresh == nil {
                self?.activityView.isHidden = !state
                self?.activityView.startAnimating()
                self?.setupRefreshControl()
            } else {
                if state {
                    if refresh?.isRefreshing == false {
                        refresh?.beginRefreshing()
                    }
                } else {
                    self?.activityView.stopAnimating()
                    refresh?.endRefreshing()
                }
            }
        })
            .addDisposableTo(disposeBag)
    }
    
    private func setupRefreshControl() {
        
        let refresh = UIRefreshControl()
        refresh.tintColor = activityView.tintColor
        refresh.addTarget(self, action: #selector(self.handleRefresh(sender:)), for: .valueChanged)
        tableView.refreshControl = refresh
    }
    
    internal func handleRefresh(sender:UIRefreshControl) {
        addressBook.load()
    }

    func showAddAddressView() {
        
        let addAddressView = loadViewFromXib(name: "AddressBook", index: 2,
                                             frame: self.parent!.view.frame) as! AddAddressView
        addAddressView.add = ({[weak self] (name) in
            self?.addressBook.addNewMyAddress(at: name)
        })
        self.parent?.view.addSubview(addAddressView)
    }
    
    internal func didSelectItem(contact:Contact) {
        
    }
    
    private func showErrorAlert(at error:NSError) {
        
        let alert = AlertsHelper.errorAlert(at: error)
        present(alert, animated: true, completion: nil)
    }
}
