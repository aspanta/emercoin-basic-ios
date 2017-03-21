//
//  MyAdressViewController.swift
//  EmercoinBasic
//

import UIKit

class MyAdressViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet internal weak var tableView:UITableView!
    
    var addressBook = AddressBook()
    
    var isMyAddressBook = true
    
    override class func storyboardName() -> String {
        return "CoinOperations"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isMyAddressBook {
            addressBook = AppManager.sharedInstance.myAddressBook
        } else {
            addressBook.stubContacts()
        }
        
        tableView.baseSetup()
        hideStatusBar()
    }

    func showAddAddressView() {
        
        let addAddressView = loadViewFromXib(name: "AddressBook", index: 2,
                                             frame: self.parent!.view.frame) as! AddAddressView
        addAddressView.add = ({(name) in
            let contact = Contact()
            contact.name = name
            contact.address = String.randomStringWithLength(10) as String
            
            self.addressBook.add(contact: contact)
            self.tableView.reload()
        })
        self.parent?.view.addSubview(addAddressView)
    }
    
    internal func didSelectItem(contact:Contact) {
        
    }
}
