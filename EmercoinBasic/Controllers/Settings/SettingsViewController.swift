//
//  SettingsViewController.swift
//  EmercoinOne
//

import UIKit

class SettingsViewController: ButtonBarPagerTabStripViewController {
    
    let mainColor:UIColor = UIColor(hexString: Constants.Colors.Coins.Emercoin)
    let backgroundColor = UIColor(hexString: "#EAEAEA")

    override class func storyboardName() -> String {
        return "Settings"
    }
    
    override func viewDidLoad() {
        
        setupUI()
        
        super.viewDidLoad()

    }
    
    deinit {
        
        if Constants.Permissions.PrintDeinit {
            print("deinit - "+String(describing: self))
        }
    }
    
    private func setupUI() {
        
        let view = UIView.statusView()
        let color = UIColor(hexString: Constants.Colors.Status.Settings)
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
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let firstVC = BaseSettingsViewController.controller()
        let secondVC = ExchangeSettingsViewController.controller()
    
        return [firstVC, secondVC]
    }

}
