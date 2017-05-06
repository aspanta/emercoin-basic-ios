//
//  LicensiesViewController.swift
//  EmercoinBasic
//

import UIKit

class LicensiesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet internal weak var tableView:UITableView!

    var licensies = Licensies()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        licensies.load()
        tableView.baseSetup()
    }
    
    override class func storyboardName() -> String {
        return "Legal"
    }
    
    override func back() {
        
        if parent is SideMenuViewController {
            backToDashBoard()
        } else {
            super.back()
        }
    }

}
