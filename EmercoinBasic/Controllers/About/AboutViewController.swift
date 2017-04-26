//
//  AboutViewController.swift
//  EmercoinBasic
//

import UIKit

class AboutViewController: BaseViewController {

    @IBOutlet weak var textView:BaseTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override class func storyboardName() -> String {
        return "About"
    }
    
    override func viewDidLayoutSubviews() {
        self.textView.setContentOffset(.zero, animated: false)
    }

}
