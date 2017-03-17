//
//  SettingsViewController.swift
//  EmercoinOne
//

import UIKit

class SettingsViewController: BaseViewController {

    @IBOutlet internal weak var encryptionButtonView:EncryptionButtonView!
    @IBOutlet internal weak var encryptionStateLabel:UILabel!
    @IBOutlet internal weak var languageButton:UIButton!
    @IBOutlet internal weak var currencyButton:UIButton!
    @IBOutlet internal weak var languageLabel:UILabel!
    @IBOutlet internal weak var currencyLabel:UILabel!
    
    var languageDropDown:DropDown?
    var currencyDropDown:DropDown?
    
    override class func storyboardName() -> String {
        return "Settings"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLanguageDropDown()
        setupCurrencyDropDown()
    }
    
    override func setupUI() {
        super.setupUI()
        
        addStatusBarView(color:UIColor(hexString: Constants.Colors.Status.Settings))
        
        encryptionButtonView.encryption = {on in
            let text = on ? "On" : "Off"
            self.encryptionStateLabel.text = text
        }
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Basic")
    }
    
    internal func setupLanguageDropDown() {
        
        languageDropDown = DropDown()
        languageDropDown?.anchorView = languageButton
        
        let dataSource = ["English", "Russian"]
        
        languageLabel.text = dataSource.first
        
        languageDropDown?.dataSource = dataSource
        
        languageDropDown?.selectionAction = { [unowned self] (index, item) in
            self.languageLabel.text = item
        }
        
        languageDropDown?.bottomOffset = CGPoint(x: 0, y: languageButton.bounds.height)
        
        setupDropDownUI()
        
    }
    
    internal func setupDropDownUI() {
        
        let appearance = DropDown.appearance()
        appearance.selectionBackgroundColor = languageLabel.textColor
        appearance.cellHeight = languageButton.bounds.height + 5
        appearance.textFont = UIFont(name: "Roboto-Regular", size: 18)!
    }
    
    @IBAction func languageButtonPressed() {
        
        languageDropDown?.show()
    }
    
    internal func setupCurrencyDropDown() {
        
        currencyDropDown = DropDown()
        currencyDropDown?.anchorView = currencyButton
        
        let dataSource = ["USD", "EUR"]
        
        currencyLabel.text = dataSource.first
        
        currencyDropDown?.dataSource = dataSource
        
        currencyDropDown?.selectionAction = { [unowned self] (index, item) in
            self.currencyLabel.text = item
        }
        
        currencyDropDown?.bottomOffset = CGPoint(x: 0, y: currencyButton.bounds.height)
        
    }
    
    @IBAction func currencyButtonPressed() {
        
        currencyDropDown?.show()
    }
}
