//
//  NoteInfoVIew.swift
//  EmercoinBasic
//

import UIKit

class RecordInfoVIew: PopupView {
    
    @IBOutlet internal weak var nameTextView:BaseTextView!
    @IBOutlet internal weak var valueTextView:BaseTextView!
    @IBOutlet internal weak var addressLabel:UILabel!
    @IBOutlet internal weak var expiresLabel:UILabel!
    
    var viewModel:RecordViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        
        if let viewModel = viewModel {
            
            let date = String(format:"%@ %@",viewModel.expiresInDay, viewModel.expiresType)
            let name = viewModel.name
            let value =  String.isInfoCardType(at: name) ? "<Infocard>" : viewModel.value
            let address = viewModel.address
    
            nameTextView.text = name
            valueTextView.text = value
            addressLabel.text = address
            expiresLabel.text = date
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.valueTextView.isScrollEnabled = true
            self.nameTextView.isScrollEnabled = true
        }
    }
}
