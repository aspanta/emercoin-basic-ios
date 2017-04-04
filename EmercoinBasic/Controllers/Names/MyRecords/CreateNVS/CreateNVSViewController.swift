//
//  CreateNVSViewController.swift
//  EmercoinBasic
//

import UIKit

class CreateNVSViewController: BaseViewController {
    
    @IBOutlet internal weak var prefixButton:UIButton!
    @IBOutlet internal weak var prefixDropLabel:UILabel!
    @IBOutlet internal weak var dateLabel:UILabel!
    @IBOutlet internal weak var expiresLabel:UILabel!
    @IBOutlet internal weak var prefixLabel:UILabel!
    @IBOutlet internal weak var prefixView:UIView!
    @IBOutlet internal weak var lineView:UIView!
    
    @IBOutlet internal weak var nameTextField:BaseTextField!
    @IBOutlet internal weak var valueTextField:BaseTextView!
    @IBOutlet internal weak var addressTextField:BaseTextField!
    @IBOutlet internal weak var timeTextField:BaseTextField!
    
    @IBOutlet internal weak var heightConstraint:NSLayoutConstraint!
    @IBOutlet internal weak var prefixConstraint:NSLayoutConstraint!
    
    @IBOutlet internal weak var createButton:UIButton!
    
    var prefixDropDown:DropDown?
    
    var created:((_ record:BCNote) -> (Void))?
    
    var isEditingMode = false
    var record:BCNote?
    
    var data:Any? {
        didSet{
            if let dict = data as? [String:Any] {
                
                if let name = dict["name"] as? String {
                    self.name = name
                }
                
                if let prefix = dict["prefix"] as? String {
                    self.prefix = prefix
                }
            }
        }
    }
    
    var name = ""
    var prefix = ""
    
    override class func storyboardName() -> String {
        return "Names"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPrefixDropDown()
    }

    override func setupUI() {
        super.setupUI()
        
        hideStatusBar()
        
        if isEditingMode {
            let value = heightConstraint.constant
            heightConstraint.constant = value - 41.0
            prefixConstraint.constant = 0
            createButton.setTitle("Save", for: .normal)
            prefixView.isHidden = isEditingMode
            lineView.isHidden = isEditingMode
            expiresLabel.text = "Extend days:"
            nameTextField.disableEdit = true
            
            if record != nil {
                nameTextField.text = record?.name
                valueTextField.text = record?.value
                addressTextField.text = record?.address
                timeTextField.text = String(format:"%i",(record?.timeValue)!)
                dateLabel.text = record?.timeType.value
            }
        } else {
            if name.length > 0 {
                nameTextField.text = name
            }
            
            if prefix.length > 0 {
                prefixLabel.text = prefix
            }
        }
        
        if isIphone5() {
            
            let font = UIFont(name: "Roboto-Regular", size: 14)
            
            nameTextField.font = font
            valueTextField.font = font
            addressTextField.font = font
            timeTextField.font = font
        }
    }
    
    internal func setupPrefixDropDown() {
        
        prefixDropDown = DropDown()
        prefixDropDown?.anchorView = prefixButton
        
        let dataSource = ["Any", "dns", "ssh", "dpo"]
        
        prefixDropLabel.text = dataSource.first
        
        prefixDropDown?.dataSource = dataSource
        
        prefixDropDown?.selectionAction = { [unowned self] (index, item) in
            self.prefixDropLabel.text = item
            self.prefixLabel.text = index != 0 ? item+":" : ""
        }
        
        prefixDropDown?.bottomOffset = CGPoint(x: 0, y: prefixButton.bounds.height)
        
        setupDropDownUI()
        
    }
    
    internal func setupDropDownUI() {
        
        let appearance = DropDown.appearance()
        appearance.selectionBackgroundColor = prefixDropLabel.textColor
        appearance.cellHeight = prefixButton.bounds.height + 7
        appearance.textFont = UIFont(name: "Roboto-Regular", size: 18)!
    }
    
    @IBAction func prefixButtonPressed() {
        
        prefixDropDown?.show()
    }
    
    @IBAction func createButtonPressed() {
        
        let prefix = prefixLabel.text!
        let name = nameTextField.text!
        let value = valueTextField.text!
        let address = addressTextField.text!
        var time = timeTextField.text!
        let date = dateLabel.text!
        
        time = time.length > 0 ? time : "0"
        
        let fullName = (prefix.length > 0) ? (prefix+" \(name)") : name
        
        let timeType = self.timeType(at: date)
        
        let record = BCNote.init(name: fullName, value:value , address: address, timeValue: Int(time)!, timeType: timeType)
        
        if isEditingMode {
            self.record?.value = record.value
            self.record?.address = record.address
            self.record?.timeType = record.timeType
            self.record?.timeValue = record.timeValue
        }
        
        if created != nil {
            created!(record)
        }
        
        back()
    }
    
    private func timeType(at string:String) -> TimeType {
        
        switch string.lowercased() {
            case "days":return .days
            case "months":return .months
            case "years":return .years
        default: return .days
        }
        
    }
    
    @IBAction func cancelButtonPressed() {
        
        back()
    }
    
    @IBAction func addressButtonPressed() {
        
        if isEditingMode {
            showRecepientAddressController()
        } else {
            showAddressesController()
        }
    }
    
    private func showAddressesController() {
    
        let controller = NamesViewController.controller() as! NamesViewController
        controller.subController = .addresses
        controller.selectedAddress = {address in
            self.addressTextField.text = address
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showRecepientAddressController() {
        
        let controller = RecipientAddressNVSViewController.controller() as! RecipientAddressNVSViewController
        controller.selectedAddress = {address in
            self.addressTextField.text = address
        }
        navigationController?.pushViewController(controller, animated: true)
    }

}
