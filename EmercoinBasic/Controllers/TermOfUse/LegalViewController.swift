//
//  TermOfUseViewController.swift
//  EmercoinBasic
//

import UIKit

class LegalViewController: BaseTextViewController {
    
    @IBOutlet internal weak var textLabel:FRHyperLabel!
    
    var viewModel:LicenseViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    override class func storyboardName() -> String {
        return "Legal"
    }
    
    func updateUI() {
        
        if let viewModel = viewModel {
         
            let font = UIFont.systemFont(ofSize: 15.0)
            let font2 = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
            
            let attributes = [NSForegroundColorAttributeName: UIColor.black,
                              NSFontAttributeName: font]
            
            let text = String(format:"%@\n\n%@",viewModel.name, viewModel.text)
            
            textLabel.attributedText = NSAttributedString(string: text, attributes: attributes)
            
            let handler = {[weak self]
                (hyperLabel: FRHyperLabel?, substring: String?) -> Void in
                
                let url = viewModel.url
                
                if let url = URL(string: url) {
                    UIApplication.shared.open(url, options: [:])
                }
            }
            
            textLabel.setLinksForSubstrings([viewModel.name], withLinkHandler: handler)
        }
    }
}

