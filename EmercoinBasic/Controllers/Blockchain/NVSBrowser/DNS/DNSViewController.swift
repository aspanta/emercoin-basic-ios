//
//  DNSViewController.swift
//  EmercoinOne
//

import UIKit

class DNSViewController: BaseViewController {

    @IBOutlet internal weak var zoneButton:UIButton!
    @IBOutlet internal weak var zoneLabel:UILabel!
    
    @IBOutlet internal var nameTextField:BaseTextField!
    
    var zoneDropDown:DropDown?
    
    var createPressed: ((_ data:Any) -> (Void))?
    
    override class func storyboardName() -> String {
        return "Blockchain"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupZoneDropDown()
    }
    
    override func setupUI() {
        super.setupUI()
        
        statusBarView?.backgroundColor = UIColor(hexString: Constants.Colors.Status.Blockchain)
    }
    
    internal func setupZoneDropDown() {
        
        zoneDropDown = DropDown()
        zoneDropDown?.anchorView = zoneButton
        
        let dataSource = ["Any", "lib", "coin", "bazar"]
        
        zoneLabel.text = dataSource.first
        
        zoneDropDown?.dataSource = dataSource
        
        zoneDropDown?.selectionAction = { [unowned self] (index, item) in
            self.zoneLabel.text = item
        }
        
        zoneDropDown?.bottomOffset = CGPoint(x: 0, y: zoneButton.bounds.height)
        
        setupDropDownUI()
        
    }
    
    internal func setupDropDownUI() {
        
        let appearance = DropDown.appearance()
        appearance.selectionBackgroundColor = zoneLabel.textColor
        appearance.cellHeight = zoneButton.bounds.height + 7
        appearance.textFont = UIFont(name: "Roboto-Regular", size: 18)!
    }
    
    @IBAction func zoneButtonPressed() {
        
        zoneDropDown?.show()
    }
    
    @IBAction func dnsInfoButtonPressed() {
        let vc = NVSInfoViewController.controller() as! NVSInfoViewController
        vc.infoType = .dns
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func searchButtonPressed() {
        
        showResultsController()
    }
    
    private func showResultsController() {
        let controller = SearchNVSResultsViewController.controller() as! SearchNVSResultsViewController
        controller.searchText = nameTextField.text!
        controller.createPressed = {[weak self] data in
            
            if let dict = data as? [String:Any] {
                if let name = dict["name"] as? String {
                    
                    let prefix = "dns:"
                    
                    let newData = ["name":name,"prefix":prefix]
                    
                    if self?.createPressed != nil {
                        self?.createPressed!(newData)
                    }
                }
            }
        }
        navigationController?.pushViewController(controller, animated: true)
    }

}
