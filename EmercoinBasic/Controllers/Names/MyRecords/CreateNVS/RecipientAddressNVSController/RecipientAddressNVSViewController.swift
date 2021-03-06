//
//  RecipientAddressNVSViewController.swift
//  EmercoinBasic
//

import UIKit

class RecipientAddressNVSViewController: BaseViewController {
    
    var selectedAddress:((_ address:String) -> (Void))?
    
    override class func storyboardName() -> String {
        return "Names"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupUI() {
        super.setupUI()
        
        hideStatusBar()
    }

    private func showEnterAddressView() {
        
        let frame = UIScreen.main.bounds
        
        let enterView = loadViewFromXib(name: "MyRecords", index: 1,
                                          frame: frame) as! EnterAddressRecordView
        enterView.text = { address in
            if address.length > 0 {
                self.returnAddressAndBack(address: address)
            }
        }
        
        self.parent?.parent!.view.addSubview(enterView)
    }
    
    private func showScanQRCodeController() {
        
        let controller = ScanQRCodeController.controller() as! ScanQRCodeController
        controller.scanned = {(data)in
            
            let dict = data as! [String:Any]
            let name = dict["name"] as? String
            let isEmercoin = (name == "emercoin") ? true : false
            
            let alert = UIAlertController(
                title: "",
                message: String (format:"QR-Code is not emercoin address"),
                preferredStyle: .alert
            )

            if !isEmercoin {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                        
                    }))
                    self.parent?.parent!.present(alert, animated: true, completion: nil)
                }
            } else {
                self.returnAddressAndBack(address: data["address"] as! String)
            }
            
        }
        
        present(controller, animated: true, completion: nil)
    }
    
    private func showAddressBookController() {
        
        let controller = NamesViewController.controller() as! NamesViewController
        controller.subController = .addresses
        controller.selectedAddress = {address in
           self.returnAddressAndBack(address: address)
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func returnAddressAndBack(address:String) {
        
        if self.selectedAddress != nil {
            self.selectedAddress!(address)
            self.back()
        }
    }
    
    @IBAction func qrCodeButtonPressed(sender:UIButton) {
        showScanQRCodeController()
    }
    
    @IBAction func listButtonPressed(sender:UIButton) {
        showAddressBookController()
    }
    
    @IBAction func enterButtonPressed(sender:UIButton) {
        showEnterAddressView()
    }
}
