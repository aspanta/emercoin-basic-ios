//
//  LoginViewController.swift
//  EmercoinOne
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {
    
    @IBOutlet internal weak var loginButton:LoginButton!
    @IBOutlet internal weak var loginTextField:BaseTextField!
    @IBOutlet internal weak var passwordTextField:BaseTextField!
    @IBOutlet internal weak var topConstraint:NSLayoutConstraint!

    let disposeBag = DisposeBag()
    var viewModel = LoginViewModel()
    
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
        
        viewModel.isValidCredentials.bindTo(loginButton.rx.isEnabled)
            .addDisposableTo(disposeBag)
        viewModel.topConstraint.bindTo(topConstraint.rx.constant)
            .addDisposableTo(disposeBag)
        
        viewModel.prepareUI()
    }
    
    @IBAction func loginButtonPressed(sender:UIButton) {
        
        let main = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = main.instantiateViewController(withIdentifier: "SideMenuViewController")
        let nav = BaseNavigationController(rootViewController: controller)
        
        present(nav, animated: true, completion: nil)
    }
    
    @IBAction func registerButtonPressed(sender:UIButton) {
        
        showRegisterController()
    }
    
    @IBAction func myServerButtonPressed(sender:UIButton) {
        
        showEnterMyServerController()
    }
    
    private func showRegisterController() {
    
        let controller = RegistrationViewController.controller()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showEnterMyServerController() {
        
        let controller = EnterToMyServerViewController.controller()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func livecoinLogin(_ sender: Any) {
        let controller = ProtectionModuleViewController.controller()
        navigationController?.pushViewController(controller, animated: true)
    }

}
