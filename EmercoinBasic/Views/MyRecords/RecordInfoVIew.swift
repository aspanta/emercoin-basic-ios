//
//  NoteInfoVIew.swift
//  EmercoinBasic
//

import UIKit

class RecordInfoVIew: PopupView {

    @IBOutlet internal weak var nameLabel:UILabel!
    @IBOutlet internal weak var valueLabel:UILabel!
    @IBOutlet internal weak var addressLabel:UILabel!
    @IBOutlet internal weak var timeLabel:UILabel!
    
    var viewModel:BCNoteViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        
        if viewModel != nil {
            nameLabel.text = viewModel?.name
            valueLabel.text = viewModel?.value
            addressLabel.text = viewModel?.address
            timeLabel.text = String(format:"%i %@",(viewModel?.timeValue)!, (viewModel?.timeType.value)!)
        }
    }

}
