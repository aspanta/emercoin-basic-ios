//
//  BCNoteCell.swift
//  EmercoinBasic
//

import UIKit

class RecordCell: BaseTableViewCell {

    @IBOutlet weak var nameLabeL:UILabel!
    @IBOutlet weak var timeValue:UILabel!
    @IBOutlet weak var timeType:UILabel!
    
    var timePressed: ((_ indexPath:IndexPath) -> (Void))?
    
    override func updateUI() {
        
        guard let viewModel = object as? RecordViewModel else {
            return
        }
        
        nameLabeL.text = viewModel.name
        timeValue.text = viewModel.expiresInDay
        timeType.text = viewModel.expiresType
    }
    
    @IBAction func timeButtonPressed() {
        print("timeButtonPressed")
        
        if timePressed != nil {
            timePressed!(indexPath!)
        }
    }

}
