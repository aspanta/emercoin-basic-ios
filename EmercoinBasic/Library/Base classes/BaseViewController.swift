//
//  BaseViewController.swift
//  EmercoinBasic
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate, TabBarObjectInfo {
    
    internal var activiryIndicator:UIActivityIndicatorView?
    internal var operationActivityView:UIView?
    
    var tabBarObject: TabBarObject?
    
    internal weak var statusBarView:UIView?
    
    var object:AnyObject?
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    deinit {
        
        if Constants.Permissions.PrintDeinit {
            print("deinit - "+String(describing: self))
        }
    }
    
    func setupUI() {
        addStatusBarView(color: UIColor.init(hexString: Constants.Colors.Status.Main))
    }
    
    func hideNavBar(state:Bool) {
        navigationController?.navigationBar.isHidden = state
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func hideStatusBar() {
        statusBarView?.isHidden = true
    }
    
    func addStatusBarView(color:UIColor? = nil) {
        
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 20.0))
        let color = color ?? UIColor(hexString: Constants.Colors.Status.Main)
        view.backgroundColor = color
        
        if statusBarView != nil {
            statusBarView?.backgroundColor = color
            statusBarView?.isHidden = false
        } else {
            statusBarView = view
            self.view.addSubview(view)
        }
    }
    
    func showErrorAlert(at error:NSError) {
        let alert = AlertsHelper.errorAlert(at: error)
        present(alert, animated: true, completion: nil)
    }
    
    func showCopyView() {
        
        let copyView:UIView = loadViewFromXib(name: "AddressBook", index: 3,
                                              frame: nil)
        copyView.alpha = 0;
        view.addSubview(copyView)
        
        copyView.center = view.center
        
        UIView.animate(withDuration: 0.3) {
            copyView.alpha = 0.8
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.3, animations: {
                copyView.alpha = 0.0
            }, completion: { (state) in
                copyView.removeFromSuperview()
            })
        }
    }
    
    func showSuccesOperationView() {
        
        let successView = getOperationView(at: 1) as! SuccessSendView
        self.parent?.view.addSubview(successView)
    }
    
    func showOperationActivityView() {
        
        let view = getOperationView(at: 2)
        self.operationActivityView = view
        userInteraction(at: false)
        self.parent?.view.addSubview(view)
    }
    
    func hideOperationActivityView() {
        
        if let view = operationActivityView {
            userInteraction(at: true)
            view.removeFromSuperview()
        }
    }
    
    func getOperationView(at index:Int) -> UIView {
        let view = loadViewFromXib(name: "Send", index: index,
                                   frame: self.parent!.view.frame)
        return view
    }
    
    @IBAction internal func lockButtonPressed() {
        let protectionHelper = WalletProtectionHelper()
        protectionHelper.fromController = self
        protectionHelper.startProtection()
    }
    
    @IBAction func menuShow() {
        Router.sharedInstance.sideMenu?.showLeftView(animated: true, completionHandler: {})
    }
    
    @IBAction func menuHide() {
        Router.sharedInstance.sideMenu?.hideLeftView(animated: true, completionHandler: {})
    }
    
    @IBAction func back() {
        self.navigationController?.popViewController(animated: true)
    }
}
