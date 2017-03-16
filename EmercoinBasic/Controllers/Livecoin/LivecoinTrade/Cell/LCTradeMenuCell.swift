//
//  LCTradeMenuCell.swift
//  EmercoinOne
//

import UIKit

class LCTradeMenuCell: BaseTableViewCell {

    @IBOutlet internal weak var titleLabel:UILabel!
    
    override func updateUI() {
        
        guard let title = object as? String else {
            return
        }
        
        titleLabel.text = title
    }

}
