//
//  RegistrationViewController.swift
//  EmercoinOne
//

import UIKit
import RxSwift
import RxCocoa

class RegistrationViewController: BaseViewController {

    @IBOutlet internal weak var registerButton:LoginButton!
    @IBOutlet internal weak var checkButton:CheckButton!
    @IBOutlet internal weak var loginTextField:BaseTextField!
    @IBOutlet internal weak var passwordTextField:BaseTextField!
    @IBOutlet internal weak var confirmPasswordTextField:BaseTextField!
    @IBOutlet internal weak var topConstraint:NSLayoutConstraint!
    @IBOutlet internal weak var leftConstraint:NSLayoutConstraint!
    
    let disposeBag = DisposeBag()
    var viewModel = RegisterViewModel()
    
    override class func storyboardName() -> String {
        return "Login"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        super.setupUI()
        
        loginTextField.textChanged = {(text) in
            self.viewModel.login = text
        }
        
        passwordTextField.textChanged = {(text) in
            self.viewModel.password = text
        }
        
        confirmPasswordTextField.textChanged = {(text) in
            self.viewModel.confirmPassword = text
        }
        
        viewModel.isValidCredentials.bindTo(registerButton.rx.isEnabled)
            .addDisposableTo(disposeBag)
        viewModel.topConstraint.bindTo(topConstraint.rx.constant)
            .addDisposableTo(disposeBag)
        viewModel.leftConstraint.bindTo(leftConstraint.rx.constant)
            .addDisposableTo(disposeBag)
        
        viewModel.prepareUI()
    }
    
    @IBAction func registerButtonPressed(sender:UIButton) {
        back()
        
    }
    
    @IBAction func checkButtonPressed(sender:UIButton) {
        let isChecked = !checkButton.isChecked
        checkButton.isChecked = isChecked
        viewModel.isChecked = isChecked
    }
    
    @IBAction func policyButtonPressed(sender:UIButton) {
        print("policyButtonPressed")
        
    }

}
