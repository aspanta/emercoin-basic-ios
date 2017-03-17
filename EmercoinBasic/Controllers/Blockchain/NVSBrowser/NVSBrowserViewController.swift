//
//  NVSBrowserViewController.swift
//  EmercoinOne
//

import UIKit

class NVSBrowserViewController: UIViewController, IndicatorInfoProvider {

    var createPressed: ((_ data:Any) -> (Void))?
    
     var viewDidAppear: ((Void) -> (Void))?
    
    override class func storyboardName() -> String {
        return "Blockchain"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if viewDidAppear != nil {
            viewDidAppear!()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func showController(at index:Int) {
        
        switch index {
            case 0:self.nvsButtonPressed()
            default:break
        }
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "NVS Browser")
    }
    
    @IBAction func nvsButtonPressed() {
        showNVSController()
    }
    
    private func showNVSController() {
    
        let vc = SearchNVSViewController.controller() as! SearchNVSViewController
        vc.createPressed = createPressed
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
