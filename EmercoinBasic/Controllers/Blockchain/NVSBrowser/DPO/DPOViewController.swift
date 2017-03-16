//
//  DPOViewController.swift
//  EmercoinOne
//

import UIKit

class DPOViewController: BaseViewController {
    
    @IBOutlet internal weak var brandButton:UIButton!
    @IBOutlet internal weak var brandLabel:UILabel!
    
    var brandDropDown:DropDown?
    
    override class func storyboardName() -> String {
        return "Blockchain"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBrandDropDown()
    }
    
    override func setupUI() {
        super.setupUI()
        
        statusBarView?.backgroundColor = UIColor(hexString: Constants.Colors.Status.Blockchain)
    }
    
    internal func setupBrandDropDown() {
        
        brandDropDown = DropDown()
        brandDropDown?.anchorView = brandButton
        
        let dataSource = ["Rocket", "Comet", "Source", "Dawn"]
        
        brandLabel.text = dataSource.first
        
        brandDropDown?.dataSource = dataSource
        
        brandDropDown?.selectionAction = { [unowned self] (index, item) in
            self.brandLabel.text = item
        }
        
        brandDropDown?.bottomOffset = CGPoint(x: 0, y: brandButton.bounds.height)
        
        setupDropDownUI()
        
    }
    
    internal func setupDropDownUI() {
        
        let appearance = DropDown.appearance()
        appearance.selectionBackgroundColor = brandLabel.textColor
        appearance.cellHeight = brandButton.bounds.height + 7
        appearance.textFont = UIFont(name: "Roboto-Regular", size: 18)!
    }
    
    @IBAction func brandButtonPressed() {
        
        brandDropDown?.show()
    }
    
    @IBAction func dpoInfoButtonPressed() {
        let vc = NVSInfoViewController.controller() as! NVSInfoViewController
        vc.infoType = .dpo
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func findButtonPressed() {
        let vc = BrandInfoViewController.controller() as! BrandInfoViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
