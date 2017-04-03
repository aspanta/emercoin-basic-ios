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
        
        guard let viewModel = object as? BCNoteViewModel else {
            return
        }
        
        nameLabeL.text = viewModel.name
        timeValue.text = String(viewModel.timeValue)
        timeType.text = viewModel.timeType.value
    }
    
    @IBAction func timeButtonPressed() {
        print("timeButtonPressed")
        
        if timePressed != nil {
            timePressed!(indexPath!)
        }
    }

}
