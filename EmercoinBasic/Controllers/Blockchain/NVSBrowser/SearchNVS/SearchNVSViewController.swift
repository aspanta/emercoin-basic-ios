//
//  SearchNVSViewController.swift
//  EmercoinBasic
//

import UIKit

class SearchNVSViewController: BaseViewController {
    
    @IBOutlet internal var nameTextField:BaseTextField!

    override class func storyboardName() -> String {
        return "Blockchain"
    }
    
    var createPressed: ((_ data:Any) -> (Void))?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupUI() {
        super.setupUI()
        
        addStatusBarView(color: UIColor(hexString: Constants.Colors.Status.Blockchain))
    }
    
    @IBAction func searchButtonPressed() {
        
        showResultsController()
    }
    
    private func showResultsController() {
        let controller = SearchNVSResultsViewController.controller() as! SearchNVSResultsViewController
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
