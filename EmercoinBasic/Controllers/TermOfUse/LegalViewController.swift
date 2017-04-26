//
//  TermOfUseViewController.swift
//  EmercoinBasic
//

import UIKit

class LegalViewController: BaseViewController {
    
    @IBOutlet weak var textView:BaseTextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override class func storyboardName() -> String {
        return "Legal"
    }
    
    override func viewDidLayoutSubviews() {
        self.textView.setContentOffset(.zero, animated: false)
    }
    
    override func back() {
        
        if parent is SideMenuViewController {
            backToDashBoard()
        } else {
            super.back()
        }
    }
    
    
}
