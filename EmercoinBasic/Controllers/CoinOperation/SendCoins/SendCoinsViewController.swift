//
//  SendCoinsViewController.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

class SendCoinsViewController: BaseViewController {
    
    @IBOutlet internal weak  var addressTextField:BaseTextField!
    @IBOutlet internal weak  var signLabel:UILabel!
    @IBOutlet internal weak  var sendButton:BaseButton!
    @IBOutlet internal weak  var amountTextField:BaseTextField!
    
    private var amount:Double = 0
    
    let disposeBag = DisposeBag()
    var viewModel = SendViewModel()
    
    override class func storyboardName() -> String {
        return "CoinOperations"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSend()
        setupActivityIndicator()
    }
    
    override func setupUI() {
        super.setupUI()
        
        hideStatusBar()
        viewModel.coinSign.bindTo(signLabel.rx.text)
        .addDisposableTo(disposeBag)
        
        if object != nil {
            guard let dict = object as? [String:Any] else {
                return
            }
            
            guard let address = dict["address"] as? String else {
                return
            }
            addressTextField.text = address
            
            guard let amount = dict["amount"] as? String else {
                return
            }
            amountTextField.text = amount
        }
    }
    
    private func setupSend() {
        
        viewModel.success.subscribe(onNext:{[weak self] success in
            if success {
                let wallet = AppManager.sharedInstance.wallet
                wallet.balance -= self?.amount ?? 0
                wallet.loadInfo(completion: nil)
                self?.showSuccesSendView()
            }
        })
            .addDisposableTo(disposeBag)
        
        viewModel.error.subscribe(onNext:{ [weak self] error in
            self?.showErrorAlert(at: error)
        })
            .addDisposableTo(disposeBag)
        
        viewModel.walletLock.subscribe(onNext:{ [weak self] state in
            if let parent = self?.parent as? CoinOperationsViewController {
                parent.lockButtonPressed()
            }
        })
            .addDisposableTo(disposeBag)
        
        addressTextField.textChanged = {[weak self](text) in
            self?.checkValidation()
        }
        
        amountTextField.textChanged = {[weak self](text) in
            self?.checkValidation()
        }
    }
    
    private func checkValidation() {
        
        let address = addressTextField.text ?? ""
        let amount = amountTextField.text ?? ""
        
        sendButton.isEnabled = !address.isEmpty && !amount.isEmpty
    }
    
    private func setupActivityIndicator() {
        
        viewModel.activityIndicator.subscribe(onNext:{ [weak self] state in
            if state {
                self?.showActivityIndicator()
            } else {
                self?.hideActivityIndicator()
            }
            
        })
            .addDisposableTo(disposeBag)
    }
    
    private func addRequestSendView() {
    
        var amount = amountTextField.text ?? ""
        amount = amount.replacingOccurrences(of: ",", with: ".")
        amount = String.dropZero(at: amount)
        self.amount = Double(amount) ?? 0
        let address = addressTextField.text
        
        if (amount.length) > 0 && (address?.length)! > 0  {
        
            let requestSendView:RequestSendView! = loadViewFromXib(name: "Send", index: 0,
                                                                   frame: self.parent!.view.frame) as! RequestSendView
            
            requestSendView.amount = amount
            requestSendView.sendCoins = ({[weak self] in
                let data = [address ?? "", self?.amount as Any] as AnyObject
                self?.viewModel.checkWalletAndSend(at: data)
            })
             self.parent?.view.addSubview(requestSendView)
        }
    }
    
    private func showSuccesSendView() {
        
        let successView:SuccessSendView! = loadViewFromXib(name: "Send", index: 1,
                                                           frame: self.parent!.view.frame) as! SuccessSendView
        successView.success = ({
            
            let parent  = self.parent as! CoinOperationsViewController
            
            parent.back()
        })
        
        self.parent?.view.addSubview(successView)
    }
    
    private func showErrorAlert(at error:NSError) {
        
        let alert = AlertsHelper.errorAlert(at: error)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sendButtonPressed(sender:UIButton) {
        
        addRequestSendView()
    }
}
