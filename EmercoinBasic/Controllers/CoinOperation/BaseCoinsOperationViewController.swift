//
//  BaseCoinsOperationViewController.swift
//  EmercoinOne
//

import UIKit
import RxSwift
import RxCocoa

enum CoinsOperation {
    case recipientAddress
    case send
    case get
    case historyAndOperations
    case myAddress
    case exchangeCoins
}

enum Side:Int{
    case left
    case right
}

class BaseCoinsOperationViewController: BaseViewController {
    
    @IBOutlet internal weak var headerView:CoinsOpeartionHeaderView!
    @IBOutlet internal weak var operationLabel:UILabel!
    @IBOutlet internal weak var menuButton:UIButton!
    @IBOutlet internal weak var backButton:UIButton!
    @IBOutlet internal weak var addButton:UIButton!
    
    @IBOutlet internal weak var operationConstraint:NSLayoutConstraint!
    
    @IBOutlet internal weak var container:UIView!
    
    var coinType:CoinType = .emercoin {
        didSet {
            viewModel.coinType = coinType
        }
    }
    
    var switchController:((Void) -> (Void))?
    
    var coinsOperation:CoinsOperation = .recipientAddress
    var side:Side = .right
    
    let viewModel = CoinsOperationViewModel()
    let disposeBag = DisposeBag()
    
    var childController:UIViewController?
    
    override class func storyboardName() -> String {
        return "CoinsOperation"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareChildController()
        viewModel.coinType = coinType
    }
    
    override func setupUI() {
        super.setupUI()
        
        var text = ""
        
        var isMenuHide = false
        
        var count = 0
        
        if let countVC =  navigationController?.viewControllers.count {
            count = countVC
        }
        
        switch coinsOperation {
        case .recipientAddress:
            text = Constants.Controllers.CoinsOperation.RecipientAddress
            isMenuHide = count > 1
        case .get:
            text = Constants.Controllers.CoinsOperation.Get
            isMenuHide = count > 1
        case .send:
            text = Constants.Controllers.CoinsOperation.Send
            isMenuHide = true
        case .historyAndOperations: operationConstraint.constant = 0.0
            isMenuHide = true
        case .myAddress:
            text = Constants.Controllers.CoinsOperation.MyAddress
            addButton.isHidden = false
            isMenuHide = true;
        case .exchangeCoins:
            let isBitcoin = coinType == .bitcoin
            text = isBitcoin ? Constants.Controllers.CoinsOperation.ExchangeCoins.Bitcoin :
                                Constants.Controllers.CoinsOperation.ExchangeCoins.Emercoin
            isMenuHide = true;
        }
        
        if side == .right && coinType == .bitcoin {
            isMenuHide = true
        }
        
        headerView.bitcoinImageView.isHidden = !(side == .left && coinType == .emercoin)
        
        menuButton.isHidden = isMenuHide
        backButton.isHidden = !isMenuHide
        
        operationLabel.text = text
        
        viewModel.coinTitle.bindTo(headerView.coinTitleLabel.rx.text)
            .addDisposableTo(disposeBag)
        viewModel.coinImage.bindTo(headerView.coinImageView.rx.image)
            .addDisposableTo(disposeBag)
        viewModel.coinCourseTitle.bindTo(headerView.coinCourseLabel.rx.attributedText)
            .addDisposableTo(disposeBag)
        viewModel.coinAmount.bindTo(headerView.coinAmountLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        viewModel.headerColor.subscribe(onNext: { [weak self] color in
            UIView.animate(withDuration: 0.1) {
                self?.headerView.backgroundColor = color
                self?.operationLabel.textColor = color
                
                guard let statusView = self?.statusBarView,
                    let statusColor = self?.viewModel.statusColor else {
                        return
                }
                
                statusView.backgroundColor = statusColor
                
                self?.addButton.setImage(self?.viewModel.addImage, for: .normal)
                
                if self?.coinsOperation == .get {
                    var text = self?.operationLabel.text
                    text = String(format:"%@ %@",text!,(self?.viewModel.coinSign)!)
                    self?.operationLabel.text = text
                }
            }
        }).addDisposableTo(disposeBag)
        
    }
    
    private func prepareChildController() {
        
        var controller:UIViewController? = nil
        
        switch coinsOperation {
        case .recipientAddress:
            let vc = RecipientAddressViewController.controller() as! RecipientAddressViewController
            vc.coinType = coinType
            controller = vc
        case .send:
            let vc = SendCoinsViewController.controller() as! SendCoinsViewController
            vc.viewModel = viewModel
            vc.object = object
            controller = vc
        case .get:
            let vc = GetCoinsViewController.controller() as! GetCoinsViewController
            vc.viewModel = viewModel
            controller = vc
        case .historyAndOperations:
            let vc = AccountPageViewController.controller() as! AccountPageViewController
            vc.coinType = coinType
            controller = vc
        case .myAddress:
            let vc = MyAdressViewController.controller() as! MyAdressViewController
            vc.coinType = coinType
            controller = vc
        case .exchangeCoins:
            let vc = ExchangeCoinsViewController.controller() as! ExchangeCoinsViewController
            vc.viewModel = viewModel
            controller = vc
        }
        
        if controller != nil {
            addChildViewController(controller!)
            controller?.view.frame.size = container.frame.size
            container.addSubview((controller?.view)!)
            didMove(toParentViewController: controller!)
            self.childController = controller
        }
    }
    
    @IBAction func addButtonPressed(sender:UIButton) {
        if childController is MyAdressViewController {
            let controller = childController as! MyAdressViewController
            controller.showAddAddressView()
        }
    }
    
    override func back() {
        
        if side == .right && switchController != nil {
            switchController!()
        } else {
            super.back()
        }
    }
}
