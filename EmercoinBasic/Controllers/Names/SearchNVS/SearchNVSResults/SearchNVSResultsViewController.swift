//
//  SearchNVSResultsViewController.swift
//  EmercoinBasic
//

import UIKit
import RxCocoa
import RxSwift

class SearchNVSResultsViewController: MyRecordsViewController {
    
    @IBOutlet internal var textLabel:UILabel!
    
    var createPressed: ((_ data:Any) -> (Void))?
    
    override class func storyboardName() -> String {
        return "Names"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = String(format:"Your query\n %@\n not found",filterString)
    }
    
    @IBAction func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createButtonPressed() {
       // parent?.navigationController?.popViewController(animated: true)
        
        let name = filterString
        
        let data = ["name":name]
        
        if createPressed != nil {
            createPressed!(data)
        }
        parent?.navigationController?.popToRootViewController(animated: true)
    }
    
    override func nvsInfoButtonPressed() {
        let vc = NVSInfoViewController.controller()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
