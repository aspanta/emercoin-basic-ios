//
//  BlockchainLoadingViewController.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

class BlockchainLoadingViewController: BaseViewController {

    private weak var blockchainLoadingView:BlockchainLoadingView?
    private let viewModel = BlockchainLoadingViewModel()
    private let disposeBag = DisposeBag()
    
    var blocks = 0
    
    override class func storyboardName() -> String {
        return "BlockchainLoading"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupController()
        showBlockchainLoadingView(at:blocks)
    }
    
    private func setupController() {
    
        viewModel.success.subscribe(onNext: {[weak self] (state) in
            if state == true {
                self?.hideBlockchainLoadingView()
                self?.showMainController()
            }
        })
            .addDisposableTo(disposeBag)
        
        viewModel.blocks.subscribe(onNext: {[weak self] (blocks) in
            self?.showBlockchainLoadingView(at: blocks)
        })
            .addDisposableTo(disposeBag)
    }
    
    private func showMainController() {
        
        Router.sharedInstance.showMainController()
    }
    
    private func showBlockchainLoadingView(at blocks:Int) {
        
        if let view = blockchainLoadingView {
            view.blocks = blocks
        } else {
            let view = loadViewFromXib(name: "Blockchain", index: 0, frame: self.view.frame) as! BlockchainLoadingView
            view.blocks = blocks
            view.checkBlockchain = {
                self.viewModel.loadBlockChainInfo()
            }
            view.cancel = {
                view.removeFromSuperview()
                AppManager.sharedInstance.logOut()
                self.blockchainLoadingView = nil
            }
            self.blockchainLoadingView = view
            self.view.addSubview(view)
        }
    }
    
    private func hideBlockchainLoadingView() {
        
        if let view = blockchainLoadingView {
            view.stopTimer()
            view.removeFromSuperview()
        }
    }

}
