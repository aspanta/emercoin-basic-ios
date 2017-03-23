//
//  HistoryViewController.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

class HistoryViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet internal weak var tableView:UITableView!
    @IBOutlet internal weak var activityView:UIActivityIndicatorView!
    
    var history = History()
    
    let disposeBag = DisposeBag()
    
    override class func storyboardName() -> String {
        return "AccountPage"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.baseSetup()
        setupHistory()
        setupActivityIndicator()
        history.load()
    }
    
    private func setupRefreshControl() {
        
        let refresh = UIRefreshControl()
        refresh.tintColor = activityView.tintColor
        refresh.addTarget(self, action: #selector(self.handleRefresh(sender:)), for: .valueChanged)
        tableView.refreshControl = refresh
    }
    
    internal func handleRefresh(sender:UIRefreshControl) {
        history.load()
    }
    
    private func setupHistory() {
        
        history.success.subscribe(onNext:{ [weak self] success in
            if success {self?.tableView.reload()}
        })
        .addDisposableTo(disposeBag)
        
        history.error.subscribe(onNext:{ [weak self] error in
            self?.showErrorAlert(at: error)
        })
        .addDisposableTo(disposeBag)
    }
    
    private func setupActivityIndicator() {
        
        history.activityIndicator.subscribe(onNext:{ [weak self] state in
            
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
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "History")
    }
    
    private func showErrorAlert(at error:NSError) {
        
        let alert = UIAlertController(
            title: "Error",
            message: String (format:error.domain),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
