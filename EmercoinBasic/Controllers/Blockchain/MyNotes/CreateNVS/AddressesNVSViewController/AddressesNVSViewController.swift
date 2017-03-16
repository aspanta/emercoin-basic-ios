//
//  AddressesNVSViewController.swift
//  EmercoinOne
//

import UIKit

class AddressesNVSViewController: MyAdressViewController {
    
    @IBOutlet internal weak var titleLabel:UILabel!
    
    var selectedAddress:((_ address:String) -> (Void))?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        coinType = .emercoin
    }
    
    override class func storyboardName() -> String {
        return "Blockchain"
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if !isMyAddressBook {
            titleLabel.text = "List of recipients"
        }
        
        addStatusBarView(color: UIColor(hexString: Constants.Colors.Status.Blockchain))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   internal override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        tableView.deselectRow(at: indexPath, animated: true)
    
        let contact = itemAt(indexPath: indexPath)
    
        if selectedAddress != nil {
            selectedAddress!(contact.address!)
        }
    
        back()
    }

}
