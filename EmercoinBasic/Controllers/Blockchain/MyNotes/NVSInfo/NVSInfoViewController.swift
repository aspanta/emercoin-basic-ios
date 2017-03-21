//
//  NVSInfoViewController.swift
//  EmercoinBasic
//

import UIKit

let nvsInfo = "EmerCoin (Emerkoin) - a new generation cryptocurrency, which allows not only to exchange money, but also offers a range of unique technologies. On the basis of a block Cheyne EmerCoin developed decentralized advertising system emcLNX, secure authentication system on the sites emcSSL, smart authentication servers through emcSSH and more. On this page is a list of publications about cryptocurrency EmerCoin, as well as instructions for installing, configuring, and using numerous services based on this technology exchange.\n\nFirst - define: Emer - is a technology and network infrastructure. Emerkoin - credit units, which circulate within Emer network. But since so accepted that the word EmerCoin called all together, we will also follow the generally accepted semantics of using the word Emer, just when we want to emphasize that we are talking about technology, not settlement and accounting aspects."

let dpoInfo = "What is EMC DPO?\n\nEmerCoin (Emerkoin) is a new generation of crypto currency that allows not only to exchange money, but also offers a whole range of unique technologies. On the basis of the block-chef EmerCoin, a decentralized advertising system emcLNX, a secure authorization system on emcSSL sites, smart authorization on servers through emcSSH and much more. This page contains a list of publications about Emerald's crypto currency, as well as instructions for installing, configuring and using numerous services based on the technologies of this currency.\n\nFirst, we define: Emer is technology, network and infrastructure. Emercoin is a credit unit that circulates inside the Emer network. But since it is so accepted that the word EmerCoin is called all together, we will also follow the generally accepted semantics, applying the word Emer, only when we want to emphasize that it is the technology, and not the accounting and accounting aspect."

enum InfoType {
    case dpo
    case nvs
    case dns
}

class NVSInfoViewController: BaseViewController {
    
    @IBOutlet internal weak var infoTextView:BaseTextView!
    
    var infoType:InfoType = .nvs
    
    override class func storyboardName() -> String {
        return "Blockchain"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupUI() {
        super.setupUI()
        
        statusBarView?.backgroundColor = UIColor(hexString: Constants.Colors.Status.Blockchain)
        
        var text = ""
        
        switch infoType {
            case .nvs:text = nvsInfo
            case .dpo:text = dpoInfo
            case .dns:text = dpoInfo
        }
        infoTextView.text = text
    }
    
}
