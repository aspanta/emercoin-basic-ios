//
//  FeedbackViewController.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

class FeedbackViewController: BaseViewController {
    
    @IBOutlet internal weak var nameTextField:BaseTextField!
    @IBOutlet internal weak var emailTextField:BaseTextField!
    @IBOutlet internal weak var subjectTextField:BaseTextField!
    @IBOutlet internal weak var placeHolderLabel:UILabel!
    @IBOutlet internal weak var messageTextView:BaseTextView!
    @IBOutlet internal weak var sendButton:FeedBackSendButton!
    
    
    let disposeBag = DisposeBag()
    var viewModel = FeedbackViewModel()
    

    override class func storyboardName() -> String {
        return "Feedback"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.textChanged = { [weak self] text in
            self?.viewModel.email = text
        }
        
        subjectTextField.textChanged = {[weak self] text in
            self?.viewModel.subject = text
        }

        messageTextView.textChanged = {[weak self] text in
            self?.viewModel.text = text
        }
        
        viewModel.isValidCredentials.bindTo(sendButton.rx.isEnabled)
            .addDisposableTo(disposeBag)
        viewModel.isPlaceholderHiden.bindTo(placeHolderLabel.rx.isHidden)
            .addDisposableTo(disposeBag)
        
    }
    
    @IBAction func sendButtonPressed() {
        
        addSuccesSendView()
    }
    
    private func addSuccesSendView() {
        
        let successView = loadViewFromXib(name: "Feedback", index: 0,
                                                           frame: self.parent!.view.frame) as! SuccessSendMessage
        successView.success = ({
            self.backToDashBoard()
        })
        
        self.parent?.view.addSubview(successView)
    }

}
