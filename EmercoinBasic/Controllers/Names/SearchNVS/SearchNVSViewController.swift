//
//  SearchNVSViewController.swift
//  EmercoinBasic
//

import UIKit

class SearchNVSViewController: BaseViewController, IndicatorInfoProvider {
    
    @IBOutlet internal var nameTextField:BaseTextField!

    override class func storyboardName() -> String {
        return "Names"
    }
    
    var createPressed: ((_ data:Any) -> (Void))?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupUI() {
        super.setupUI()
        
        hideStatusBar()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Search NVS")
    }
    
    @IBAction func searchButtonPressed() {
        
        showResultsController()
    }
    
    private func showResultsController() {
        let controller = NamesViewController.controller() as! NamesViewController
        controller.subController = .searchResults
        controller.searchText = nameTextField.text!
        controller.createPressed = createPressed
        navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func nvsInfoButtonPressed() {
        let vc = NVSInfoViewController.controller() as! NVSInfoViewController
        vc.infoType = .dpo
        navigationController?.pushViewController(vc, animated: true)
    }
}