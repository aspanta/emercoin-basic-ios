//
//  CreateNVSViewController.swift
//  EmercoinOne
//

import UIKit

class CreateNVSViewController: BaseViewController {
    
    @IBOutlet internal weak var prefixButton:UIButton!
    @IBOutlet internal weak var dateButton:UIButton!
    @IBOutlet internal weak var prefixDropLabel:UILabel!
    @IBOutlet internal weak var dateLabel:UILabel!
    @IBOutlet internal weak var prefixLabel:UILabel!
    @IBOutlet internal weak var titleLabel:UILabel!
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
    var dateDropDown:DropDown?
    
    var create:((_ record:BCNote) -> (Void))?
    
    var isEditingMode = false
    var record:BCNote?
    
    var name:String? = ""
    var prefix:String? = ""
    
    override class func storyboardName() -> String {
        return "Blockchain"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPrefixDropDown()
        setupDateDropDown()
    }

    override func setupUI() {
        super.setupUI()
        
        statusBarView?.backgroundColor = UIColor(hexString: Constants.Colors.Status.Blockchain)
        
        if isEditingMode {
            titleLabel.text = "Edit NVS"
            let value = heightConstraint.constant
            heightConstraint.constant = value - 41.0
            prefixConstraint.constant = 0
            createButton.setTitle("Save", for: .normal)
            prefixView.isHidden = isEditingMode
            lineView.isHidden = isEditingMode
            nameTextField.disableEdit = true
            
            if record != nil {
                nameTextField.text = record?.name
                valueTextField.text = record?.value
                addressTextField.text = record?.address
                timeTextField.text = String(format:"%i",(record?.timeValue)!)
                dateLabel.text = record?.timeType.value
            }
        } else {
            if (name?.length)! > 0 {
                nameTextField.text = name
            }
            
            if (prefix?.length)! > 0 {
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
    
    internal func setupDateDropDown() {
        
        dateDropDown = DropDown()
        dateDropDown?.anchorView = dateButton
        
        let dataSource = ["Days", "Months", "Years"]
        
        if !isEditingMode {
            dateLabel.text = dataSource.first
        }
        
        dateDropDown?.dataSource = dataSource
        
        dateDropDown?.selectionAction = { [unowned self] (index, item) in
            self.dateLabel.text = item
        }
        
        dateDropDown?.bottomOffset = CGPoint(x: 0, y: dateButton.bounds.height)
        
    }
    
    @IBAction func dateButtonPressed() {
        
        dateDropDown?.show()
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
        
        if create != nil {
            create!(record)
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
    
        let controller = AddressesNVSViewController.controller() as! AddressesNVSViewController
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
