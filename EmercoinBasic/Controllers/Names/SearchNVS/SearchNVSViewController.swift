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
    
    private func showResultsController(at records:Records) {
        
        let controller = NamesViewController.controller() as! NamesViewController
        controller.subController = .searchResults
        controller.records = records
        controller.createPressed = createPressed
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func showOperationActivityView() {
        var controller:UIViewController?
        
        if let parent = self.parent?.parent as? NamesViewController  {
            controller = parent
        } else {
            if let parent = self.parent as? NamesViewController {
                controller = parent
            }
        }
        
        if let controller = controller {
            let view = getOperationView(at: 2)
            view.frame = controller.view.frame
            self.operationActivityView = view
            userInteraction(at: false)
            controller.view.addSubview(view)
        }
    }
    
    @IBAction func searchButtonPressed() {
        
        if isLoading == true {return}
        
        showOperationActivityView()
        
        let records = Records()
        let text = nameTextField.text?.copy() as! String
        records.searchString = text
        isLoading = true
        
        records.searchName {[weak self] in
            self?.hideOperationActivityView()
            self?.isLoading = false
            self?.showResultsController(at: records)
            self?.nameTextField.text = ""
            self?.nameTextField.resignFirstResponder()
            self?.checkValidation()
        }
    }

    @IBAction func nvsInfoButtonPressed() {
        
        let vc = NVSInfoViewController.controller() as! NVSInfoViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
