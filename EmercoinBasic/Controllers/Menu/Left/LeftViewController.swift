//
//  LeftViewController.swift
//  EmercoinOne
//
//  Created by Sergey Lyubeznov on 14/02/2017.
//  Copyright © 2017 Aspanta. All rights reserved.
//

import UIKit

class LeftViewController: BaseViewController {
    
    @IBOutlet internal weak var tableView:UITableView!
    
    var menuItems:[MenuItem] = []
    
    var width:CGFloat = 0
    
    var pressed:((_ index:Int, _ subIndex:Int) -> (Void))?

    override func viewDidLoad() {
        super.viewDidLoad()

        addMenuItems()
        setupController()
        tableView.baseSetup()
    }
    
    private func setupController() {
        
        statusBarView?.backgroundColor = UIColor(hexString: Constants.Colors.Status.Menu)
        statusBarView?.frame.size.width = width
    }
    
    private func addMenuItems() {
        
        let homeMenuItem = MenuItem(title: Constants.Controllers.Menu.Home.Title,
                                        image: Constants.Controllers.Menu.Home.Image)
        let sendMenuItem = MenuItem(title: Constants.Controllers.Menu.Send.Title,
                                    image: Constants.Controllers.Menu.Send.Image)
        let getMenuItem = MenuItem(title: Constants.Controllers.Menu.Get.Title,
                                    image: Constants.Controllers.Menu.Get.Image)
        let bctoolsMenuItem = MenuItem(title: Constants.Controllers.Menu.BCTools.Title,
                                    image: Constants.Controllers.Menu.BCTools.Image)
        let settingsMenuItem = MenuItem(title: Constants.Controllers.Menu.Settings.Title,
                                    image: Constants.Controllers.Menu.Settings.Image)
        let aboutMenuItem = MenuItem(title: Constants.Controllers.Menu.About.Title,
                                    image: Constants.Controllers.Menu.About.Image)
        let contactsMenuItem = MenuItem(title: Constants.Controllers.Menu.Contacts.Title,
                                    image: Constants.Controllers.Menu.Contacts.Image)
        let politicsMenuItem = MenuItem(title: Constants.Controllers.Menu.Politics.Title,
                                    image: Constants.Controllers.Menu.Politics.Image)
        let exitMenuItem = MenuItem(title: Constants.Controllers.Menu.Exit.Title,
                                    image: Constants.Controllers.Menu.Exit.Image)
        
        menuItems = [homeMenuItem,sendMenuItem,getMenuItem,bctoolsMenuItem,settingsMenuItem,
                    aboutMenuItem,contactsMenuItem,politicsMenuItem,exitMenuItem]
        
    }

}
