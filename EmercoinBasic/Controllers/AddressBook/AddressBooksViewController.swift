//
//  AddressBooksViewController.swift
//  EmercoinOne
//

import UIKit

class AddressBooksViewController: CoinsOperationViewController {
    
    var selectedAddress:((_ text:String) -> (Void))?
    
    override class func storyboardName() -> String {
        return "AddressBook"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepareChildController() {
        
        guard let vc = childViewControllers.first as? BasePageViewController else {
            return
        }
        
        let firstVc = newController(coinType: firstControllerType) as! AddressBookViewController
        let secondVc = newController(coinType: secondControllerType) as! AddressBookViewController
        firstVc.side = .left; secondVc.side = .right
        
        vc.orderedViewControllers = [firstVc, secondVc]
    }
    
    override func newController(coinType: CoinType) -> UIViewController {
        
        let controller = AddressBookViewController.controller() as! AddressBookViewController
        controller.coinType = coinType
        controller.selectedAddress = selectedAddress
        return controller
    }

}
