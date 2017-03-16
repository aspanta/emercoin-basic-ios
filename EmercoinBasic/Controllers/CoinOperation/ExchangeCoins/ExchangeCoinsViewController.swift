//
//  ExchangeCoinsViewController.swift
//  EmercoinOne
//

import UIKit
import RxSwift
import RxCocoa

class ExchangeCoinsViewController: BaseViewController {
    
    @IBOutlet internal weak  var signLabel:UILabel!
    @IBOutlet internal weak  var courseLabel:UILabel!
    @IBOutlet internal weak  var getLabel:UILabel!
    @IBOutlet internal weak  var sendButton:UIButton!
    @IBOutlet internal weak  var amountTextField:BaseTextField!
    
    let disposeBag = DisposeBag()
    var viewModel:CoinsOperationViewModel?

    override class func storyboardName() -> String {
        return "CoinsOperation"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountTextField.textChanged = {text in
            
            var amount:Double = 0.0
            
            if let value = Double(text) {
                amount = value
            }
            
            self.viewModel?.exchangeAmount = amount
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        hideStatusBar()
        
        signLabel.text = viewModel?.coinSign
        
        viewModel?.headerColor.subscribe(onNext: { [weak self] color in
            UIView.animate(withDuration: 0.1) {
                self?.sendButton.backgroundColor = color
            }
        }).addDisposableTo(disposeBag)
        
        viewModel?.exchangeRate.bindTo(courseLabel.rx.text)
            .addDisposableTo(disposeBag)
        viewModel?.getCoins.bindTo(getLabel.rx.text)
            .addDisposableTo(disposeBag)
    }
    
    @IBAction func exchangeButtonPressed() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showSuccesExhangeView()
        }
    }
    
    private func showSuccesExhangeView() {
        
        let successView:SuccessSendView! = loadViewFromXib(name: "Send", index: 1,
                                                           frame: self.parent!.view.frame) as! SuccessSendView
        successView.success = ({
            
            let parent  = self.parent as! BaseCoinsOperationViewController
        
            parent.back()
        })
        
        self.parent?.view.addSubview(successView)
    }
    
}
