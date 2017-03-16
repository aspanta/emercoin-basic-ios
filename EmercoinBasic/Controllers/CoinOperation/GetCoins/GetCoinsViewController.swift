//
//  GetCoinsViewController.swift
//  EmercoinOne
//

import UIKit
import RxSwift
import RxCocoa

class GetCoinsViewController: BaseViewController {
    
    @IBOutlet internal weak var coinSignLabel:UILabel!
    @IBOutlet internal weak var addressLabel:UILabel!
    @IBOutlet internal weak var amountTextField:BaseTextField!
    @IBOutlet internal weak var qrCodeImageView:UIImageView!
    @IBOutlet internal weak var dropDownButton:UIButton!
    
    @IBOutlet internal weak var centerContentHeight:NSLayoutConstraint!
    @IBOutlet var bottomConstraints: [NSLayoutConstraint]!
    
    var viewModel:CoinsOperationViewModel? = nil {
        didSet {
            if viewModel != nil {
                updateUI()
            }
        }
    }
    var dropDown:DropDown?
    
    let disposeBag = DisposeBag()
    
    override class func storyboardName() -> String {
        return "CoinsOperation"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountTextField.textChanged = {(text)in
            self.generateQRCode()
        }
        
        setupDropDown()
        generateQRCode()
    }
    
    override func setupUI() {
        super.setupUI()
        
        hideStatusBar()
        
        if isIphone5() {
            let value = CGFloat(Constants.Controllers.Get.iphone5)
            centerContentHeight.constant -= value
            
            bottomConstraints.forEach({ constraint in
                constraint.constant -= value / 2.0
            })
        }
    }
    
    private func updateUI() {
        viewModel?.headerColor.subscribe(onNext: { [weak self] color in
            UIView.animate(withDuration: 0.1) {
                self?.coinSignLabel.textColor = color
                self?.coinSignLabel.text = self?.viewModel?.coinSign
                self?.setupDropDownUI()
            }
        }).addDisposableTo(disposeBag)
    }
    
    @IBAction func sendButtonPressed(sender:UIButton) {
       showShareController()
    }
    
    @IBAction func copyButtonPressed(sender:UIButton) {
        
        UIPasteboard.general.string = addressLabel.text
        showCopyView()
    }
    
    private func showShareController() {
        
        let text = addressLabel.text as Any
        let image = qrCodeImageView.image as Any
        
        let activityViewController = UIActivityViewController(activityItems: [text, image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private func showCopyView() {
        
        let copyView:UIView = loadViewFromXib(name: "AddressBook", index: 3,
                                              frame: nil)
        copyView.alpha = 0;
        view.addSubview(copyView)
        
        copyView.center = view.center
        
        UIView.animate(withDuration: 0.3) {
            copyView.alpha = 0.8
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.3, animations: {
                copyView.alpha = 0.0
            }, completion: { (state) in
                copyView.removeFromSuperview()
            })
        }
        
    }
    
    internal func generateQRCode() {
        
        let address = addressLabel.text
        var amount = amountTextField.text
        
        let name = viewModel?.coinType == .bitcoin ? "bitcoin" : "emercoin"
        var text = ""
        
        if (address?.length)! > 0 {
            text =  name+":\(address!)"
            
            if (amount?.length)! > 0 && amount != "0" {
                amount = amount?.replacingOccurrences(of: ",", with: ".")
                text = text+"?amount=\(amount!)"
            }
            
            QRCodeHelper.generateQRCode(at: text, size: qrCodeImageView.frame.size, completion: { (image) in
                self.qrCodeImageView.image = image
            })
        }
    }
}
