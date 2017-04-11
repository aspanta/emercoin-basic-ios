//
//  NoteInfoVIew.swift
//  EmercoinBasic
//

import UIKit

class RecordInfoVIew: PopupView {

//    @IBOutlet internal weak var nameLabel:UILabel!
//    @IBOutlet internal weak var valueLabel:UILabel!
//    @IBOutlet internal weak var addressLabel:UILabel!
//    @IBOutlet internal weak var timeLabel:UILabel!
//    @IBOutlet internal weak var scrollView:UIScrollView!
    
    @IBOutlet internal weak var textView:BaseTextView!
    
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
            
            let text = String(format:"%@\n\n%@\n\n%@\n\n%@",name,value,
                              viewModel.address,date)
            textView.text = text
        }
    }
    
    override func didMoveToSuperview() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {

            self.textView.isScrollEnabled = true
        }
    }
}
