//
//  PutOrderCell.swift
//  EmercoinOne
//

import UIKit

class PutOrderCell: BaseTableViewCell {

    @IBOutlet internal weak var coinLabel:UILabel!
    @IBOutlet internal weak var coinFirstLabel:UILabel!
    @IBOutlet internal weak var coinSecondAmountLabel:UILabel!
    @IBOutlet internal weak var coinSecondSignLabel:UILabel!
    
    override func updateUI() {
        super.updateUI()
        
        guard let viewModel = object as? LCPutOrderViewModel else {
            return
        }

        coinFirstLabel.text = viewModel.coiFirst
        coinSecondAmountLabel.text = viewModel.coinSecondAmount
        coinSecondSignLabel.text = viewModel.coindSecondSign
        
        let labels = [coinLabel, coinFirstLabel, coinSecondAmountLabel, coinSecondSignLabel]
        
        labels.forEach { (label) in
            label?.textColor = viewModel.color
        }
    }
}
