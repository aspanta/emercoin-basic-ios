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

        // Do any additional setup after loading the view.
    }


    func showController(at index:Int) {
        
        switch index {
            case 0:self.dpoButtonPressed()
            case 1:self.dnsButtonPressed()
            case 2:self.nvsButtonPressed()
            default:break
        }
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "NVS Browser")
    }
    
    @IBAction func dpoButtonPressed() {
       showController(at: "dpo")
    }
    
    @IBAction func dnsButtonPressed() {
        showController(at: "dns")
    }
    
    @IBAction func nvsButtonPressed() {
        showController(at: "search")
    }
    
    private func showController(at name:String) {
        
        var controller:UIViewController?
        
        switch name {
            case "dpo":
                controller = DPOViewController.controller()
            case "dns":
                let vc = DNSViewController.controller() as! DNSViewController
                vc.createPressed = createPressed
                controller = vc
            case "search":
                let vc = SearchNVSViewController.controller() as! SearchNVSViewController
                vc.createPressed = createPressed
                controller = vc
        default:
            break
        }
        
        self.navigationController?.pushViewController(controller!, animated: true)
    }
}
