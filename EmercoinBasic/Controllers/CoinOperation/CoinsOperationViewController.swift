//
//  CoinsOperationViewController.swift
//  EmercoinOne
//

import UIKit


class CoinsOperationViewController: BaseViewController {
    
    override class func storyboardName() -> String {
        return "CoinsOperation"
    }
    
    var firstControllerType:CoinType = .emercoin
    
    var secondControllerType:CoinType = .bitcoin
    
    var coinsOperation:CoinsOperation = .recipientAddress
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareChildController()
        statusBarView?.isHidden = true
    }
    
    func prepareChildController() {
        
        guard let vc = childViewControllers.first as? BasePageViewController else {
            return
        }
        
        let firstVc = newController(coinType: firstControllerType) as! BaseCoinsOperationViewController
        let secondVc = newController(coinType: secondControllerType) as! BaseCoinsOperationViewController
        firstVc.side = .left; secondVc.side = .right
        secondVc.switchController = {
            vc.goToPreviousPage()
        }
        
        vc.orderedViewControllers = [firstVc, secondVc]
    }
    
    func newController(coinType:CoinType) -> UIViewController {
        
        let controller = BaseCoinsOperationViewController.controller() as! BaseCoinsOperationViewController
        controller.coinType = coinType
        controller.coinsOperation = coinsOperation
        
        if object != nil {
            controller.object = object
        }
        
        return controller
    }

}
