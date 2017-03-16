//
//  BrandInfoViewController.swift
//  EmercoinOne
//

import UIKit

class BrandInfoViewController: BaseViewController {
    
    @IBOutlet internal weak var noSearilView:UIView!

    override class func storyboardName() -> String {
        return "Blockchain"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        noSearilView.isHidden = arc4random_uniform(2) == 1
    }
    
    override func setupUI() {
        super.setupUI()
        
        addStatusBarView(color: UIColor(hexString: Constants.Colors.Status.Blockchain))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
