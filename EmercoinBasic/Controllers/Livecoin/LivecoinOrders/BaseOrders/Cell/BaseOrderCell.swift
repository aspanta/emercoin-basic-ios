//
//  BaseOrderCell.swift
//  EmercoinOne
//

import UIKit

class BaseOrderCell: BaseTableViewCell {
    
    @IBOutlet internal weak var timeLabel:UILabel!
    @IBOutlet internal weak var coinLabel:UILabel!
    @IBOutlet internal weak var statusLabel:UILabel!
    @IBOutlet internal weak var coinFirstLabel:UILabel!
    @IBOutlet internal weak var coinSecondAmountLabel:UILabel!
    @IBOutlet internal weak var coinSecondSignLabel:UILabel!

    override func updateUI() {
        super.updateUI()
        
        guard let viewModel = object as? LCOrderViewModel else {
            return
        }
        
        timeLabel.text = viewModel.time
        statusLabel.text = viewModel.status
        coinFirstLabel.text = viewModel.coiFirst
        coinSecondAmountLabel.text = viewModel.coinSecondAmount
        coinSecondSignLabel.text = viewModel.coindSecondSign
        
        let labels = [timeLabel, coinLabel, coinFirstLabel, coinSecondAmountLabel, coinSecondSignLabel, statusLabel]
        
        labels.forEach { (label) in
            label?.textColor = viewModel.color
        }
        
        statusLabel.isHidden = !viewModel.showStatus
        
    }

}
