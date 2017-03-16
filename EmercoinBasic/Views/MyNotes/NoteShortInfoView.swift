//
//  NoteShortInfoView.swift
//  EmercoinOne
//

import UIKit

class NoteShortInfoView: PopupView {

    @IBOutlet internal weak var infoLabel:UILabel!
    
    var viewModel:BCNoteViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        
        if viewModel != nil {
            let text = String(format:"Address %@ was create %i %@",(viewModel?.name)!,
                              (viewModel?.timeValue)!,(viewModel?.timeType.value)!)
            infoLabel.text = text
        }
    }
}
