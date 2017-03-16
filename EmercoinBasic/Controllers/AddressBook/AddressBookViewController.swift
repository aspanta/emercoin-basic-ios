//
//  AddressBookViewController.swift
//  EmercoinOne
//

import UIKit
import RxSwift
import RxCocoa

class AddressBookViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet internal weak var headerView:AdressBookHeaderView!
    @IBOutlet internal weak var operationLabel:UILabel!
    @IBOutlet internal weak var menuButton:UIButton!
    @IBOutlet internal weak var backButton:UIButton!
    @IBOutlet internal weak var addButton:UIButton!
    
    @IBOutlet internal weak var tableView:UITableView!
    
    var selectedAddress:((_ text:String) -> (Void))?
    
    var addressBook = AddressBook()
    
    let viewModel = AddressBookViewModel()
    let disposeBag = DisposeBag()
    
    var coinType:CoinType = .bitcoin {
        didSet {
        viewModel.coinType = coinType
        }
    }
    
    var side:Side = .left
    
    override class func storyboardName() -> String {
        return "AddressBook"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressBook.stubContacts()
        addressBook.cointType = coinType
        tableView.baseSetup()
        viewModel.coinType = coinType
    }
    
    override func setupUI() {
        super.setupUI()
        
        viewModel.coinImage.bindTo(headerView.coinImageView.rx.image)
            .addDisposableTo(disposeBag)
    
        viewModel.statusColor.subscribe(onNext: { [weak self] color in
            UIView.animate(withDuration: 0.1) {
                self?.operationLabel.textColor = self?.viewModel.titleColor
                self?.headerView.backgroundColor = self?.viewModel.titleColor
                guard let statusView = self?.statusBarView else {
                        return
                }
                statusView.backgroundColor = color
                
                self?.addButton.setImage(self?.viewModel.addImage, for: .normal)
            }
        }).addDisposableTo(disposeBag)

    }
    
    @IBAction func addButtonPressed(sender:UIButton) {
        
        showAddContactView()
    }
    
    private func showAddContactView() {
        
        let addContactView = loadViewFromXib(name: "AddressBook", index: 1,
                                                                   frame: self.parent!.view.frame) as! AddContactView
        addContactView.add = ({(name, address) in
            let contact = Contact()
            contact.name = name
            contact.address = address
            contact.coinType = self.coinType
            
            self.addressBook.add(contact: contact)
            self.tableView.reload()
        })
        self.parent?.view.addSubview(addContactView)
    }

}
