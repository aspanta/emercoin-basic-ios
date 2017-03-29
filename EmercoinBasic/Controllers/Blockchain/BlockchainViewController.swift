//
//  BlockchainViewController.swift
//  EmercoinBasic
//

import UIKit

class BlockchainViewController: ButtonBarPagerTabStripViewController, TabBarObjectInfo {
    
    var tabBarObject: TabBarObject?
    
    let mainColor:UIColor = UIColor(hexString: Constants.Controllers.Blockchain.HeaderColor)
    let backgroundColor = UIColor(hexString: "#EAEAEA")
    
    private var data:Any?
    private var isHasData = false
    
    var subControllerIndex = -1
    
    var viewDidAppear: ((Void) -> (Void))?
    
    private var notesController:MyNotesViewController?
    private var browserController:NVSBrowserViewController?
    
    override class func storyboardName() -> String {
        return "Blockchain"
    }
    
    override func viewDidLoad() {
        
        setupUI()
        
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if viewDidAppear != nil {
            viewDidAppear!()
        }
        
        if isHasData {
            isHasData = false
            showCreateNVSController(at: data)
        }
    }
    
    deinit {
        
        if Constants.Permissions.PrintDeinit {
            print("deinit - "+String(describing: self))
        }
    }
    
    private func setupUI() {
        
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 20.0))
        let color = UIColor(hexString: Constants.Colors.Status.Blockchain)
        view.backgroundColor = color
        
        self.view.addSubview(view)
        
        settings.style.buttonBarBackgroundColor = backgroundColor
        settings.style.buttonBarItemBackgroundColor = backgroundColor
        settings.style.selectedBarBackgroundColor = mainColor
        settings.style.buttonBarItemFont = UIFont(name: "Roboto-Regular", size: 18)!
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        settings.style.buttonBarHeight = 57.0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray
            newCell?.label.textColor = self?.mainColor
        }
    }
    
    func showBrowserSubController(at index:Int) {
        
        if self.buttonBarView.selectedIndex == 0 {
            subControllerIndex = index
           self.moveTo(viewController: self.browserController!)
        } else {
            browserController?.showController(at: index)
        }
        
    }
    
    func showMyNotesTab() {
        
        if self.buttonBarView.selectedIndex == 1 {
            self.moveTo(viewController: self.notesController!)
        } else {
        }
        
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let firstVC = MyNotesViewController.controller() as! MyNotesViewController
        let secondVC = NVSBrowserViewController.controller() as! NVSBrowserViewController
        secondVC.createPressed = {[weak self] data in
            
            self?.isHasData = true
            self?.data = data
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
                self?.moveTo(viewController: firstVC)
            }
    
        }
        
        secondVC.viewDidAppear = {
            
            if self.subControllerIndex != -1 {
                self.browserController?.showController(at: self.subControllerIndex)
                self.subControllerIndex = -1
            }
        }
        
        notesController = firstVC
        browserController = secondVC
        
        return [firstVC, secondVC]
    }
    
    @IBAction func addNoteButtonPressed() {
        showCreateNVSController(at:nil)
    }
    
    private func showCreateNVSController(at data:Any?) {
        
        let controller = CreateNVSViewController.controller() as! CreateNVSViewController
        
        if let dict = data as? [String:Any] {
            if let name = dict["name"] as? String {
                controller.name = name
            }
            
            if let prefix = dict["prefix"] as? String {
                controller.prefix = prefix
            }
        }
        
        controller.create = {record in
            self.notesController?.addNote(note: record)
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}
