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
    
    var filterString:String = ""
    
    var tableCellAction:TableCellAction = .add

    override class func storyboardName() -> String {
        return "Names"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.baseSetup()
        setupRecords()
        
        if filterString.isEmpty {
            setupRefreshControl()
            setupActivityIndicator()
            records.load()
        } else {
            records.filterString = filterString
        }
        
        updateUI()
    }
    
    private func updateUI() {
       noNotesView.isHidden = records.records.count != 0
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
                self?.updateUI()
                self?.tableView.reload()
            }
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
        
        let successView:SuccessAddNameView! = loadViewFromXib(name: "MyRecords", index: 4,
                                                              frame: self.parent!.view.frame) as! SuccessAddNameView
        self.parent?.view.addSubview(successView)
    }

}
