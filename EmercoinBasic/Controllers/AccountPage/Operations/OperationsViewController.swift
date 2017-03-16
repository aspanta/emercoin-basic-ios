//
//  OperationsViewController.swift
//  EmercoinOne
//

import UIKit

class OperationsViewController: UIViewController, IndicatorInfoProvider {

    var coinType:CoinType = .bitcoin
    
    override class func storyboardName() -> String {
        return "AccountPage"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Operations")
    }
    
    @IBAction func sendButtonPressed(sender:UIButton) {
        showSendController()
    }
    
    @IBAction func myAddressButtonPressed(sender:UIButton) {
        showMyAddressController()
    }
    
    @IBAction func addMoneyButtonPressed(sender:UIButton) {
        print("addMoneyButtonPressed")
    }
    
    @IBAction func exchangeButtonPressed(sender:UIButton) {
        showExchangeCoinsController()
        
    }
    
    @IBAction func receiveButtonPressed(sender:UIButton) {
        showReceiveController()
    }

    private func showSendController() {
        
        let controller = getController(at: .recipientAddress)
        push(at: controller)
    }
    
    private func showExchangeCoinsController() {
        
        let controller = getController(at: .exchangeCoins)
        push(at: controller)
    }
    
    private func showReceiveController() {
        
        let controller = getController(at: .get)
        push(at: controller)
    }
    
    private func showMyAddressController() {
        
        let controller = getController(at: .myAddress)
        push(at: controller)
    }
    
    private func push(at controller:UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func getController(at operationType:CoinsOperation) -> UIViewController {
        
        let controller = BaseCoinsOperationViewController.controller() as! BaseCoinsOperationViewController
        controller.coinsOperation = operationType
        controller.coinType = coinType
        return controller
    }
}
