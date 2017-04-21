//
//  LoginViewController.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {
    
    @IBOutlet internal weak var enterButton:LoginButton!
    @IBOutlet internal weak var checkButton:CheckButton!
    @IBOutlet internal weak var loginTextField:BaseTextField!
    @IBOutlet internal weak var hostTextField:BaseTextField!
    @IBOutlet internal weak var portTextField:BaseTextField!
    @IBOutlet internal weak var passwordTextField:BaseTextField!
    @IBOutlet internal weak var protocolTextField:BaseTextField!
    @IBOutlet internal weak var protocolButton:UIButton!
    @IBOutlet internal weak var topConstraint:NSLayoutConstraint!
    @IBOutlet internal weak var leftConstraint:NSLayoutConstraint!
    
    var dropDown:DropDown?
    let disposeBag = DisposeBag()
    var viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDropDown()
        
    }
    
    override class func storyboardName() -> String {
        return "Login"
    }

    
    override func setupUI() {
        super.setupUI()
        
        loginTextField.textChanged = {[weak self](text) in
            self?.viewModel.login = text
        }
        
        passwordTextField.textChanged = {[weak self](text) in
            self?.viewModel.password = text
        }
        
        hostTextField.textChanged = {[weak self](text) in
            self?.viewModel.host = text
        }
        
        portTextField.textChanged = {[weak self](text) in
            self?.viewModel.port = text
        }
        
        viewModel.isValidCredentials.bindTo(enterButton.rx.isEnabled)
            .addDisposableTo(disposeBag)
        viewModel.topConstraint.bindTo(topConstraint.rx.constant)
            .addDisposableTo(disposeBag)
        viewModel.leftConstraint.bindTo(leftConstraint.rx.constant)
            .addDisposableTo(disposeBag)
        
        setupLogin()
        
        setupActivityIndicator()

        viewModel.prepareUI()
    }
    
    private func setupLogin() {
        
        viewModel.successLogin.subscribe(onNext:{ [weak self] success in
            if success {
                self?.showMainController()
            }
        }).addDisposableTo(disposeBag)
        
        viewModel.error.subscribe(onNext:{ [weak self] error in
            self?.showErrorAlert(at: error)
        }).addDisposableTo(disposeBag)
    }
    
    private func setupActivityIndicator() {
        
        viewModel.activityIndicator.subscribe(onNext:{ [weak self] state in
            if state {
                self?.showActivityIndicator()
            } else {
                self?.hideActivityIndicator()
            }
            
        })
        .addDisposableTo(disposeBag)
    }
    
    @IBAction func enterButtonPressed(sender:UIButton) {
        
        viewModel.performLogin()
    }
    
    @IBAction func skipButtonPressed(sender:UIButton) {
        
        showMainController()
    }
    
    private func showMainController() {
        
        Router.sharedInstance.showMainController()
    }
    
    private func showErrorAlert(at error:NSError) {
        
        let alert = AlertsHelper.errorAlert(at: error)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func checkButtonPressed(sender:UIButton) {
        let isChecked = !checkButton.isChecked
        checkButton.isChecked = isChecked
        viewModel.isChecked = isChecked
    }
    
    @IBAction func policyButtonPressed(sender:UIButton) {
        let controller = PrivacyPolicyViewController.controller()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func termsButtonPressed(sender:UIButton) {
        let controller = TermOfUseViewController.controller()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func dropButtonPressed() {
        
        dropDown?.show()
    }
    
    internal func setupDropDown() {
        
        dropDown = DropDown()
        dropDown?.anchorView = protocolButton
        
        let dataSource = ["Protocol", "http", "https"]
        
        //protocolTextField.text = dataSource.first
        
        dropDown?.dataSource = dataSource
        
        dropDown?.selectionAction = { [weak self] (index, item) in
            if index == 0 {return}
            self?.protocolTextField.text = item
            self?.viewModel.webProtocol = item
        }
        
        dropDown?.customCellConfiguration = {[weak self] (index: Index, item: String, cell: DropDownCell) -> Void in
            
            if index == 0 {
                cell.isUserInteractionEnabled = false
                cell.optionLabel?.textColor = .lightGray
            }
        }
        
        dropDown?.bottomOffset = CGPoint(x: 0, y: protocolButton.bounds.height)
        
        setupDropDownUI()
        
    }
    
    internal func setupDropDownUI() {
        
        let appearance = DropDown.appearance()
        appearance.selectionBackgroundColor = UIColor(hexString: "9C73B1")
        appearance.cellHeight = protocolButton.bounds.height + 5
        appearance.textFont = UIFont(name: "Roboto-Regular", size: 17)!
    }
}
