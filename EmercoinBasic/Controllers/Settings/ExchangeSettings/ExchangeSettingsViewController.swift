//
//  ExchangeSettingsViewController.swift
//  EmercoinOne
//


import UIKit

class ExchangeSettingsViewController: UIViewController, IndicatorInfoProvider {

    override class func storyboardName() -> String {
        return "Settings"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Exchange")
    }
    
    @IBAction func livecoinButtonPressed(_ sender: Any) {
        
        showLivecoinLogin()
    }
    
    private func showLivecoinLogin() {
        let controller = LoginLiveViewController.controller()
        navigationController?.pushViewController(controller, animated: true)
    }

}
