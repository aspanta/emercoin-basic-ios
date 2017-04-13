//
//  NoteInfoVIew.swift
//  EmercoinBasic
//

import UIKit

class RecordInfoVIew: PopupView, UIScrollViewDelegate {
    
    @IBOutlet internal weak var textView:BaseTextView!
    
    var viewModel:RecordViewModel? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateUI() {
        
        if let viewModel = viewModel {
            
            
            let count = isIphone5() ? 33 : 44
            
            var separator = ""
            
            for _ in 0...count {
                separator = separator+"-"
            }
            
            let date = String(format:"%@ %@",viewModel.expiresInDay, viewModel.expiresType)
            let name = viewModel.name
            let value =  String.isInfoCardType(at: name) ? "<Infocard>" : viewModel.value
            
            let text = String(format:"%@\n%@\n%@\n%@\n%@\n%@\n%@",name,separator,value,separator,
                              viewModel.address,separator,date)
            textView.text = text
            
        }
    }
    
    override func didMoveToSuperview() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.textView.isScrollEnabled = true
            
            for view in self.textView.subviews {
                if let imageView = view as? UIImageView {
                    if imageView.alpha == 0.0 && imageView.autoresizingMask == .flexibleLeftMargin {
                        imageView.alpha = 1.0
                        imageView.frame.size.height = 128.0
                    }
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("123")
    }
}
