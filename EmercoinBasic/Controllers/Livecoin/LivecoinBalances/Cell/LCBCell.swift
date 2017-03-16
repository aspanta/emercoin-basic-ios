//
//  LCBCell.swift
//  EmercoinOne
//

import UIKit

class LCBCell: BaseTableViewCell {

    @IBOutlet internal weak var currencyTitleLabel:UILabel!
    @IBOutlet internal weak var currencyAmountLabel:UILabel!
    
    @IBOutlet internal weak var availableAmountLabel:UILabel!
    @IBOutlet internal weak var inOrdersAmountLabel:UILabel!
    
    @IBOutlet weak var arrowImageView:UIImageView!
    @IBOutlet weak var arrowButton:UIButton!
    
    var arrowPressed: ((_ indexPath:IndexPath) -> (Void))?
    
    override func updateUI() {
        super.updateUI()
        
        guard let viewModel = object as? LCCurrencyViewModel else {
            return
        }
        
        currencyTitleLabel.text = viewModel.name
        currencyAmountLabel.text = viewModel.amount
        availableAmountLabel.text = viewModel.available
        inOrdersAmountLabel.text = viewModel.inOrders
        
        let image = isExpanded ? #imageLiteral(resourceName: "lcb_arrow_up") : #imageLiteral(resourceName: "lcb_arrow_down")
        arrowButton.setImage(image, for: .normal)
    }
    
    @IBAction internal func arrowButtonPressed() {
        
        if arrowPressed != nil {
            
            guard let indexPath = self.indexPath else {
                return
            }
            arrowPressed!(indexPath)
        }
    }
}
