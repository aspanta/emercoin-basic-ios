//
//  SearchNVSViewController.swift
//  EmercoinBasic
//

import UIKit

class SearchNVSViewController: BaseViewController, IndicatorInfoProvider {
    
    @IBOutlet internal weak var nameTextField:BaseTextField!
    @IBOutlet internal weak var searchButton:BaseButton!

    override class func storyboardName() -> String {
        return "Names"
    }
    
    var createPressed: ((_ data:Any) -> (Void))?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearch()
    }
    
    override func setupUI() {
        super.setupUI()
        
        hideStatusBar()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Search NVS")
    }
    
    private func setupSearch() {
        
        nameTextField.textChanged = {[weak self](text) in
            self?.checkValidation()
        }
    }
    
    private func checkValidation() {
        
        let text = nameTextField.text ?? ""
        
        searchButton.isEnabled = !text.isEmpty
    }
    
    @IBAction func searchButtonPressed() {
        
        if isLoading == true {return}
        
        let records = Records()
        records.searchString = nameTextField.text!
        isLoading = true
        records.searchName {[weak self] in
            self?.isLoading = false
            self?.showResultsController(at: records)
        }
    }
    
    private func showResultsController(at records:Records) {
        let controller = NamesViewController.controller() as! NamesViewController
        controller.subController = .searchResults
        controller.records = records
        controller.createPressed = createPressed
        navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func nvsInfoButtonPressed() {
        let vc = NVSInfoViewController.controller() as! NVSInfoViewController
        vc.infoType = .dpo
        navigationController?.pushViewController(vc, animated: true)
    }
}
