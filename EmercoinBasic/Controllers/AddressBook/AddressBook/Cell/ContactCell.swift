//
//  ContactCell.swift
//  EmercoinOne
//
//  Created by Sergey Lyubeznov on 20/02/2017.
//  Copyright © 2017 Aspanta. All rights reserved.
//

import UIKit

class ContactCell: BaseTableViewCell {
    
    @IBOutlet weak var nameLabeL:UILabel!
    @IBOutlet weak var addressLabeL:UILabel!
    
    override func updateUI() {
        
        guard let viewModel = object as? ContactViewModel else {
            return
        }
        
        nameLabeL.text = viewModel.name
        addressLabeL.text = viewModel.address
    }
    
}
