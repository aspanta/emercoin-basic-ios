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

class MyRecordsViewController: BaseViewController, IndicatorInfoProvider, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet internal weak var tableView:UITableView!
    @IBOutlet internal weak var noNotesView:UIView!
    
    var records = Records()
    let disposeBag = DisposeBag()
    var tableCellAction:TableCellAction = .add
    
    internal var deleteRecord:Record?
    private var walletProtectionHelper:WalletProtectionHelper?
    
    internal var editingIndexPath:IndexPath?

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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let indexPath = editingIndexPath {
            self.reloadRows(at: [indexPath])
            editingIndexPath = nil
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        hideStatusBar()
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
    
    @objc internal func handleRefresh(sender:UIRefreshControl) {
        records.load()
    }
    
    private func setupRecords() {
        
        records.success.subscribe(onNext:{ [weak self] success in
            if success {
                self?.tableView.reload()
            }
            self?.updateUI()
        }).disposed(by: disposeBag)
        
        records.successDelete.subscribe(onNext:{ [weak self] success in
            if success {
                self?.showSuccessDeleteNameView()
            }
        }).disposed(by: disposeBag)
        
        records.error.subscribe(onNext:{ [weak self] error in
            self?.showErrorAlert(at: error)
        }).disposed(by: disposeBag)
        
        records.walletLock.subscribe(onNext:{ [weak self] state in
            self?.showProtection()
        }).disposed(by: disposeBag)
    }
    
    private func setupActivityIndicator() {
        
        records.activityIndicator.subscribe(onNext:{ [weak self] state in
            
            let refresh = self?.tableView.refreshControl
            
            if state == false {
                if refresh?.isRefreshing == true  {
                    refresh?.endRefreshing()
                }
                self?.hideOperationActivityView()
            } else {
                self?.showOperationActivityView()
            }
        }).disposed(by: disposeBag)
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "My NVS")
    }
    
    func addRecord(record:Record) {
        tableCellAction = .add
        records.add(record: record)
    }
    
    private func showSuccessDeleteNameView() {
        
        if let parent = self.parent?.parent as? NamesViewController  {
            showSuccessDeleteNameView(at: parent)
        } else {
            if let parent = self.parent as? NamesViewController {
                showSuccessDeleteNameView(at: parent)
            }
        }
        
        AppManager.sharedInstance.wallet.loadInfo()
    }
    
    private func showSuccessDeleteNameView(at controlller:UIViewController) {
        let successView:SuccessAddNameView! = loadViewFromXib(name: "MyRecords", index: 2,
                                                              frame: controlller.view.frame) as! SuccessAddNameView
        self.walletProtectionHelper = nil
        self.deleteRecord = nil
        controlller.view.addSubview(successView)
    }
    
    override func showOperationActivityView() {
        
        var controller:UIViewController?
        
        if let parent = self.parent?.parent as? NamesViewController  {
            controller = parent
        } else {
            if let parent = self.parent as? NamesViewController {
                controller = parent
            }
        }
        
        if let controller = controller {
            let view = getOperationView(at: 2)
            view.frame = controller.view.frame
            self.operationActivityView = view
            userInteraction(at: false)
            controller.view.addSubview(view)
        }
    }
    
    private func showProtection() {
        
        if let parent = self.parent?.parent as? NamesViewController  {
            showProtection(at: parent)
        } else {
            if let parent = self.parent as? NamesViewController {
                showProtection(at: parent)
            }
        }
    }
    
    private func showProtection(at controller:UIViewController) {
        
        let protectionHelper = WalletProtectionHelper()
        protectionHelper.fromController = controller
        
        protectionHelper.cancel = {[weak self] in
            self?.deleteRecord = nil
        }
        
        protectionHelper.unlock = {[weak self] in
            if let record = self?.deleteRecord {
                self?.records.remove(record: record)
            }
        } as (() -> (Void))
        
        self.walletProtectionHelper = protectionHelper
        protectionHelper.startProtection()
    }
    
    @IBAction func nvsInfoButtonPressed() {
        let vc = NVSInfoViewController.controller()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
