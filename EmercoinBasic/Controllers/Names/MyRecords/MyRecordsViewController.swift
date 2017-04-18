//
//  MyNotesViewController.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

enum TableCellAction {
    case remove
    case edit
    case add
}

class MyRecordsViewController: UIViewController, IndicatorInfoProvider, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet internal weak var tableView:UITableView!
    @IBOutlet internal weak var noNotesView:UIView!
    
    var records = Records()
    let disposeBag = DisposeBag()
    
    var tableCellAction:TableCellAction = .add
    
    internal var deleteRecord:Record?
    private var walletProtectionHelper:WalletProtectionHelper?

    override class func storyboardName() -> String {
        return "Names"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.baseSetup()
        setupRecords()
        
        if records.searchString.isEmpty {
            setupRefreshControl()
            setupActivityIndicator()
            records.load()
        }
        updateUI()
    }
    
    private func updateUI() {
        let count = records.searchString.isEmpty ? records.records.count : records.searchRecords.count
        noNotesView.isHidden =  count != 0
    }
    
    private func setupRefreshControl() {
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.handleRefresh(sender:)), for: .valueChanged)
        tableView.refreshControl = refresh
    }
    
    internal func handleRefresh(sender:UIRefreshControl) {
        records.load()
    }
    
    private func setupRecords() {
        
        records.success.subscribe(onNext:{ [weak self] success in
            if success {
                self?.tableView.reload()
            }
            self?.updateUI()
        })
            .addDisposableTo(disposeBag)
        
        records.successDelete.subscribe(onNext:{ [weak self] success in
            if success {
                self?.showSuccessDeleteNameView()
            }
        })
            .addDisposableTo(disposeBag)
        
        records.error.subscribe(onNext:{ [weak self] error in
            self?.showErrorAlert(at: error)
        })
            .addDisposableTo(disposeBag)
        
        records.walletLock.subscribe(onNext:{ [weak self] state in
            self?.showProtection()
        })
            .addDisposableTo(disposeBag)
    }
    
    private func setupActivityIndicator() {
        
        records.activityIndicator.subscribe(onNext:{ [weak self] state in
            
            let refresh = self?.tableView.refreshControl
            
            if state == false {
                if refresh?.isRefreshing == true  {
                    refresh?.endRefreshing()
                }
            }
        })
            .addDisposableTo(disposeBag)
    }
    
    internal func showErrorAlert(at error:NSError) {
        
        let alert = AlertsHelper.errorAlert(at: error)
        present(alert, animated: true, completion: nil)
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "My NVS")
    }
    
    func addRecord(record:Record) {
        tableCellAction = .add
        records.add(record: record)
    }
    
    @IBAction func nvsInfoButtonPressed() {
        let vc = NVSInfoViewController.controller()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showSuccessDeleteNameView() {
        
        if let parent = self.parent?.parent as? NamesViewController {
            let successView:SuccessAddNameView! = loadViewFromXib(name: "MyRecords", index: 4,
                                                              frame: parent.view.frame) as! SuccessAddNameView
            self.walletProtectionHelper = nil
            self.deleteRecord = nil
            parent.view.addSubview(successView)
        }
    }
    
    private func showProtection() {
        
        if let parent = self.parent?.parent as? NamesViewController  {
            let protectionHelper = WalletProtectionHelper()
            protectionHelper.fromController = parent
            protectionHelper.cancel = {[weak self] in
                self?.deleteRecord = nil
            }
            protectionHelper.unlock = {[weak self] in
                if let record = self?.deleteRecord {
                    self?.records.remove(record: record)
                }
            }
            self.walletProtectionHelper = protectionHelper
            protectionHelper.startProtection()
        }
    }

}
