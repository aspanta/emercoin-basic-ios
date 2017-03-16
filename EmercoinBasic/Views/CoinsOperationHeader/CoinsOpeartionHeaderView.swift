//
//  CoinsOpeartionHeaderView.swift
//  EmercoinOne
//
//  Created by Sergey Lyubeznov on 17/02/2017.
//  Copyright © 2017 Aspanta. All rights reserved.
//

import UIKit

class CoinsOpeartionHeaderView: UIView {

    @IBOutlet  weak var coinImageView:UIImageView!
    @IBOutlet  weak var bitcoinImageView:UIImageView!
    @IBOutlet  weak var backgroundImageView:UIImageView!
    @IBOutlet  weak var coinTitleLabel:UILabel!
    @IBOutlet  weak var coinCourseLabel:UILabel!
    @IBOutlet  weak var coinAmountLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
      //  dropShadow()
    }
}
