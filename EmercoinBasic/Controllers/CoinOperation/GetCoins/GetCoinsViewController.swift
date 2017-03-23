//
//  GetCoinsViewController.swift
//  EmercoinBasic
//

import UIKit

class GetCoinsViewController: BaseViewController {
    
    @IBOutlet internal weak var coinSignLabel:UILabel!
    @IBOutlet internal weak var addressLabel:UILabel!
    @IBOutlet internal weak var amountTextField:BaseTextField!
    @IBOutlet internal weak var qrCodeImageView:UIImageView!
    @IBOutlet internal weak var dropDownButton:UIButton!
    
    @IBOutlet internal weak var centerContentHeight:NSLayoutConstraint!
    @IBOutlet var bottomConstraints: [NSLayoutConstraint]!
    
    var dropDown:DropDown?
    
    override class func storyboardName() -> String {
        return "CoinOperations"
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
        
        let name = "emercoin"
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