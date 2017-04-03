//
//  AddressesNVSViewController.swift
//  EmercoinBasic
//

import UIKit

class AddressesNVSViewController: MyAdressViewController {
    
    @IBOutlet internal weak var titleLabel:UILabel!
    
    var selectedAddress:((_ address:String) -> (Void))?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override class func storyboardName() -> String {
        return "Names"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        super.setupUI()
        
        if !isMyAddressBook {
            titleLabel.text = "List of recipients"
        }
        
        hideStatusBar()
    }
    
   internal override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        tableView.deselectRow(at: indexPath, animated: true)
    
        let contact = itemAt(indexPath: indexPath)
    
        if selectedAddress != nil {
            selectedAddress!(contact.address)
        }
    
        back()
    }

}
