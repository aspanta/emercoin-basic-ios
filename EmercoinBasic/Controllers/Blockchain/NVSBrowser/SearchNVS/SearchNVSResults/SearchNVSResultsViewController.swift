//
//  SearchNVSResultsViewController.swift
//  EmercoinBasic
//

import UIKit
import RxCocoa
import RxSwift

class SearchNVSResultsViewController: MyNotesViewController {
    
    @IBOutlet internal var textLabel:UILabel!
    
    var searchText:String = ""
    
    var createPressed: ((_ data:Any) -> (Void))?
    
    override class func storyboardName() -> String {
        return "Blockchain"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        textLabel.text = String(format:"Your query: %@ is not found",searchText)

        viewModel.searchRecords(at: searchText)
    }
    
    private func setupUI() {
        
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 20.0))
        let color = UIColor(hexString: Constants.Colors.Status.Blockchain)
        view.backgroundColor = color
        
        self.view.addSubview(view)
    }
    
    @IBAction func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createButtonPressed() {
       // parent?.navigationController?.popViewController(animated: true)
        
        let name = searchText
        
        let data = ["name":name]
        
        if createPressed != nil {
            createPressed!(data)
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func nvsInfoButtonPressed() {
        let vc = NVSInfoViewController.controller()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
