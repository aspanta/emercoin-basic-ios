//
//  AddressBookViewController.swift
//  EmercoinOne
//

import UIKit

class AddressBookViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet internal weak var menuButton:UIButton!
    @IBOutlet internal weak var backButton:UIButton!
    @IBOutlet internal weak var addButton:UIButton!
    
    @IBOutlet internal weak var tableView:UITableView!
    
    var selectedAddress:((_ text:String) -> (Void))?
    
    var addressBook = AddressBook()
    
    override class func storyboardName() -> String {
        return "AddressBook"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressBook.stubContacts()
        tableView.baseSetup()
    }
    
    @IBAction func addButtonPressed(sender:UIButton) {
        
        showAddContactView()
    }
    
    private func showAddContactView() {
        
        let addContactView = loadViewFromXib(name: "AddressBook", index: 1,
                                                                   frame: self.parent!.view.frame) as! AddContactView
        addContactView.add = ({(name, address) in
            let contact = Contact()
            contact.name = name
            contact.address = address
            
            self.addressBook.add(contact: contact)
            self.tableView.reload()
        })
        self.parent?.view.addSubview(addContactView)
    }

}
