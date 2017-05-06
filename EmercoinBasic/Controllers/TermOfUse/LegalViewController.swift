//
//  TermOfUseViewController.swift
//  EmercoinBasic
//

import UIKit

class LegalViewController: BaseTextViewController {
    
    @IBOutlet internal weak var textLabel:UILabel!
    @IBOutlet internal weak var hyperlinkLabel:HyperlinkLabel!
    @IBOutlet internal weak var nameLabel:UILabel!

    private var range:NSRange?
    
    var viewModel:LicenseViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(self.tapLabel(gesture:)))
        hyperlinkLabel.addGestureRecognizer(gesture)
        hyperlinkLabel.isUserInteractionEnabled = true

        updateUI()
    }

    override class func storyboardName() -> String {
        return "Legal"
    }
    
    func updateUI() {
        
        if let viewModel = viewModel {
            textLabel.text = viewModel.text
            hyperlinkLabel.text = viewModel.url
            
            let attributes = [NSForegroundColorAttributeName: UIColor.black,
                              NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
            
            nameLabel.attributedText = NSAttributedString(string: viewModel.name, attributes: attributes)
        }
    }
    
    func tapLabel(gesture: UITapGestureRecognizer) {
        
        if let range = hyperlinkLabel.textRange {
            if gesture.didTapAttributedTextInLabel(label: hyperlinkLabel, inRange: range) {
                if let viewModel = viewModel {
                    if let url = URL(string: viewModel.url) {
                        UIApplication.shared.open(url, options: [:])
                    }
                }
            } else {
                print("Tapped none")
            }
        }
    }
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x:locationOfTouchInLabel.x - textContainerOffset.x,y:locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
