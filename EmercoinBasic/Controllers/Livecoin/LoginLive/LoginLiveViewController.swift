//
//  LoginLiveViewController.swift
//  EmercoinOne
//

import UIKit
import RxSwift
import RxCocoa



class LoginLiveViewController: BaseViewController {

    @IBOutlet internal weak var apikeyTextField:BaseTextField!
    @IBOutlet internal weak var secretkeyTextField:BaseTextField!
    @IBOutlet internal weak var loginButton:LoginButton!
    @IBOutlet internal weak var topConstraint:NSLayoutConstraint!
    
    let disposeBag = DisposeBag()
    var viewModel = LoginLiveViewModel()
    
    override class func storyboardName() -> String {
        return "Livecoin"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        apikeyTextField.textChanged = {(text) in
            self.viewModel.apiKey = text
        }
        
        secretkeyTextField.textChanged = {(text) in
            self.viewModel.secretKey = text
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        let color = UIColor(hexString: Constants.Colors.Status.Livecoin)
        addStatusBarView(color: color)
        
        viewModel.isValidCredentials.bindTo(loginButton.rx.isEnabled)
            .addDisposableTo(disposeBag)
        viewModel.topConstraint.bindTo(topConstraint.rx.constant)
            .addDisposableTo(disposeBag)
        
        viewModel.prepareUI()
    }
    
    @IBAction func loginButtonPressed() {
        
        showTradeController()
    }
    
    private func addExchangeNotWorkingView() {
        
        let view = loadViewFromXib(name: "LoginLive", index: 0,
                                              frame: self.view.frame)
        self.view.addSubview(view)
    }
    
    private func showTradeController() {
        
        let controller = LivecoinTradeViewController.controller()
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    private func addAuthErrorView() {
        
        let view = loadViewFromXib(name: "LoginLive", index: 1,
                                   frame: self.view.frame)
        self.view.addSubview(view)
    }
    
    @IBAction func error1(_ sender: Any) {
        addExchangeNotWorkingView()
    }
    @IBAction func error2(_ sender: Any) {
        addAuthErrorView()
    }
}
