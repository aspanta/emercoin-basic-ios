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
        
        loginTextField.textChanged = {(text) in
            self.viewModel.login = text
        }
        
        passwordTextField.textChanged = {(text) in
            self.viewModel.password = text
            self.viewModel.confirmPassword = text
        }
        
        hostTextField.textChanged = {(text) in
            self.viewModel.host = text
        }
        
        portTextField.textChanged = {(text) in
            self.viewModel.port = text
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
        
        viewModel.isSuccessLogin.subscribe(onNext:{ [weak self] success in
            if success {self?.showMainController()}
        })
            .addDisposableTo(disposeBag)
        
        viewModel.isError.subscribe(onNext:{ [weak self] error in
            self?.showErrorAlert(at: error)
        })
            .addDisposableTo(disposeBag)
    }
    
    private func setupActivityIndicator() {
        
        viewModel.isActivityIndicator.subscribe(onNext:{ [weak self] state in
            if state {
                self?.showActivityIndicator()
            } else {
                self?.hideActivityIndicator()
            }
            
        })
        .addDisposableTo(disposeBag)
    }
    
    private func fillData() {
        
        let host = "174.138.88.96"
        let port = "6682"
        let login = "emccoinrpc"
        let password = "iejeet2vae4rohcohh2soRasi9roha4gaigohNaezaeNgahtaichay2xaed8Meew"
        let webProtocol = "https"
        
        hostTextField.text = host
        portTextField.text = port
        loginTextField.text = login
        passwordTextField.text = password
        protocolTextField.text = webProtocol
        
        viewModel.host = host
        viewModel.port = port
        viewModel.login = login
        viewModel.password = password
        viewModel.webProtocol = webProtocol
        
        viewModel.isValidCredentials.onNext(true)
    }
    
    @IBAction func enterButtonPressed(sender:UIButton) {
        
        viewModel.performLogin()
    }
    
    @IBAction func loginInfoButtonPressed() {
        fillData()
    }
    
    @IBAction func skipButtonPressed(sender:UIButton) {
        
    AppManager.sharedInstance.wallet = Wallet(amount: 100)
        showMainController()
    }
    
    private func showMainController() {
        
        let main = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = main.instantiateViewController(withIdentifier: "SideMenuViewController")
        let nav = BaseNavigationController(rootViewController: controller)
        
        present(nav, animated: true, completion: nil)
    }
    
    private func showErrorAlert(at error:Error) {
        
        let alert = UIAlertController(
            title: "Error",
            message: String (format:error.localizedDescription),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
        print(error.localizedDescription)
    }
    
    @IBAction func checkButtonPressed(sender:UIButton) {
        let isChecked = !checkButton.isChecked
        checkButton.isChecked = isChecked
        viewModel.isChecked = isChecked
    }
    
    @IBAction func policyButtonPressed(sender:UIButton) {
        print("policyButtonPressed")
        
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
        
        dropDown?.selectionAction = { [unowned self] (index, item) in
            if index == 0 {return}
            self.protocolTextField.text = item
            self.viewModel.webProtocol = item
        }
        
        dropDown?.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            
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
