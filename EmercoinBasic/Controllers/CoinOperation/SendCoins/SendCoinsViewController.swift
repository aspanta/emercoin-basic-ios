//
//  SendCoinsViewController.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

class SendCoinsViewController: BaseViewController {
    
    @IBOutlet internal weak  var addressTextField:UITextField!
    @IBOutlet internal weak  var signLabel:UILabel!
    @IBOutlet internal weak  var sendButton:UIButton!
    @IBOutlet internal weak  var amountTextField:BaseTextField!
    
    let disposeBag = DisposeBag()
    var viewModel:CoinOperationsViewModel?
    
    override class func storyboardName() -> String {
        return "CoinOperations"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        
        hideStatusBar()
        viewModel?.coinSign.bindTo(signLabel.rx.text)
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
    
    private func addRequestSendView() {
    
        let amount = amountTextField.text
        
        if (amount?.length)! > 0 {
        
            let requestSendView:RequestSendView! = loadViewFromXib(name: "Send", index: 0,
                                                                   frame: self.parent!.view.frame) as! RequestSendView
            let requestString = String(format:"Do you want to send to the address %@ EMC?", amount!)
            requestSendView.amountLabel?.text = requestString
            requestSendView.sendCoins = ({
                //TODO: send coins
                print("ok")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.addSuccesSendView()
                }
            })
             self.parent?.view.addSubview(requestSendView)
        }
    }
    
    private func addSuccesSendView() {
        
        let successView:SuccessSendView! = loadViewFromXib(name: "Send", index: 1,
                                                           frame: self.parent!.view.frame) as! SuccessSendView
        successView.success = ({
            
            let parent  = self.parent as! CoinOperationsViewController
            
            if parent.parent is AddressBookViewController {
                print ("AddressBookViewController")
            }
            
            parent.back()
        })
        
        self.parent?.view.addSubview(successView)
    }
    
    @IBAction func sendButtonPressed(sender:UIButton) {
        print("sendButtonPressed")
        
        addRequestSendView()
    }
}
