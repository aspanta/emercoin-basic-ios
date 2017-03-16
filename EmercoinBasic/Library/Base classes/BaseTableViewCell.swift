//
//  BaseTableViewCell.swift
//  EmercoinOne
//
//  Created by Sergey Lyubeznov on 15/02/2017.
//  Copyright © 2017 Aspanta. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    var object:Any? {
        didSet {
            updateUI()
        }
    }
    
    var pressedCell: ((_ indexPath:IndexPath) -> (Void))?
    var indexPath:IndexPath?
    var isExpanded:Bool = false
    
    func updateUI() {
        
    }

}
