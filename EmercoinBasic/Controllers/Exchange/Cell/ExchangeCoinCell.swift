//
//  ExchangeCoinCell.swift
//  EmercoinOne
//

import UIKit

class ExchangeCoinCell: BaseTableViewCell {
    
    @IBOutlet weak var coinImageView:UIImageView!
    @IBOutlet weak var sellLabel:UILabel!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var buyLabel:UILabel!
    @IBOutlet weak var notWorkLabel:UILabel!
    @IBOutlet weak var notWorkView:UIView!

    override func updateUI() {
        
        guard let viewModel = object as? ExchangeCoinViewModel else {
            return
        }
        
        titleLabel.text = viewModel.title
        sellLabel.text = viewModel.sell
        buyLabel.text = viewModel.buy
        coinImageView.image = viewModel.coinImage
        
        let isWorking = viewModel.isWorking
        
        if !isWorking {
            self.notWorkView.isHidden = isWorking
            self.notWorkLabel.isHidden = isWorking
        }
    }

}
