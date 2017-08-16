//
//  GetCoinsViewController.swift
//  EmercoinBasic
//

import UIKit
import RxCocoa
import RxSwift

class GetCoinsViewController: BaseViewController {
    
    @IBOutlet internal weak var coinSignLabel:UILabel!
    @IBOutlet internal weak var addressLabel:UILabel!
    @IBOutlet internal weak var amountTextField:BaseTextField!
    @IBOutlet internal weak var qrCodeImageView:UIImageView!
    @IBOutlet internal weak var dropDownButton:UIButton!
    @IBOutlet internal weak var centerContentHeight:NSLayoutConstraint!
    @IBOutlet var bottomConstraints: [NSLayoutConstraint]!
    
    var dropDown:DropDown?
    let disposeBag = DisposeBag()
    internal var address = ""

    override class func storyboardName() -> String {
        return "CoinOperations"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountTextField.textChanged = {(text)in
            self.generateQRCode(at:self.address)
        }
        
        setupDropDown()
        generateQRCode(at:self.address)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let data = object as? [String : Any] {
            
            guard let address = data["address"] as? String else {
                return
            }
            self.address = address
            self.addressLabel.text = address
            guard let amount = data["amount"] as? String else {
                return
            }
            
            amountTextField.text = amount
            generateQRCode(at: address)
            object = nil
        }
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
        
        addressLabel.text = ""
    }
    
    private func showShareController() {
        
        let text = address as Any
        let image = qrCodeImageView.image as Any
        
        let activityViewController = UIActivityViewController(activityItems: [text, image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    internal func generateQRCode(at address:String) {
        
        var amount = amountTextField.text ?? ""
        amount.formattedNumber()
        
        let isValidAmount = amount.validAmount()
        
        let name = "emercoin"
        var text = ""
        
        if (address.length) > 0 {
            text =  name+":\(address)"
            
            if isValidAmount {
                text = text+"?amount=\(amount)"
            }
            
            QRCodeHelper.generateQRCode(at: text, size: qrCodeImageView.frame.size, completion: { (image) in
                self.qrCodeImageView.image = image
            })
        }
    }
    
    @IBAction func sendButtonPressed(sender:UIButton) {
        showShareController()
    }
    
    @IBAction func copyButtonPressed(sender:UIButton) {
        
        UIPasteboard.general.string = address
        showCopyView()
    }
}
