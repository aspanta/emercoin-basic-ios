//
//  RecipientAddressViewController.swift
//  EmercoinOne
//

import UIKit

class RecipientAddressViewController: BaseViewController {
    
    var coinType:CoinType = .bitcoin
    
    override class func storyboardName() -> String {
        return "CoinsOperation"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupUI() {
        super.setupUI()
        
        statusBarView?.isHidden = true
    }
    
    @IBAction func qrCodeButtonPressed(sender:UIButton) {
        showScanQRCodeController()
    }
    
    @IBAction func listButtonPressed(sender:UIButton) {
        print("listButtonPressed")
        showAddressBookController()
    }
    
    @IBAction func enterButtonPressed(sender:UIButton) {
        showSendController(at:nil)
    }
    
    private func showSendController(at data:[String:Any]?) {
    
        let controller = BaseCoinsOperationViewController.controller() as! BaseCoinsOperationViewController
        controller.coinsOperation = .send
        controller.object = data as AnyObject?
        controller.coinType = coinType
        push(at: controller)
    }
    
    private func showAddressBookController() {

        let controller = AddressBookViewController.controller() as! AddressBookViewController
        controller.selectedAddress = {(address)in
            var dict:[String:Any] = [:]
            dict["address"] = address
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.showSendController(at: dict)
            }
        }
        controller.coinType = coinType
        push(at: controller)
    }
    
    private func showScanQRCodeController() {
        
        let controller = ScanQRCodeController.controller() as! ScanQRCodeController
        controller.scanned = {(data)in
            
            let dict = data as! [String:Any]
            let name = dict["name"] as? String
            self.coinType = (name == "bitcoin") ? .bitcoin : .emercoin
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.showSendController(at: dict)
            }
        }
        present(controller, animated: true, completion: nil)
        //push(at: controller)
    }
    
    private func push(at controller:UIViewController) {
        
        navigationController?.pushViewController(controller, animated: true)
    }
}
