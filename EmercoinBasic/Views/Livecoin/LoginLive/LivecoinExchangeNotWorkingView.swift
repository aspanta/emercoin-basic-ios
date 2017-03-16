//
//  LivecoinExchangeNotWorkingView.swift
//  EmercoinOne
//

import UIKit

let iphone5OffSet:CGFloat = 50

class LivecoinExchangeNotWorkingView: UIView {
    
    @IBOutlet internal weak var topConstraint:NSLayoutConstraint!
    
    @IBAction func back(_ sender: Any) {
        removeFromSuperview()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        
        let view = UIView.statusView()
        let color = UIColor(hexString: Constants.Colors.Status.Livecoin)
        view.backgroundColor = color
        addSubview(view)
        
        if isIphone5() {
            topConstraint.constant = topConstraint.constant - iphone5OffSet
        }
    }
}
