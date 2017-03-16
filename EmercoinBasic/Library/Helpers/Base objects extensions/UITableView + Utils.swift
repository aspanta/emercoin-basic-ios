//
//  UITableView + Utils.swift
//  VKApp
//
//  Created by Sergey Lyubeznov on 17/01/2017.
//  Copyright © 2017 Sergey Lyubeznov. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func baseSetup() {
        self.hideEmtyCells()
        self.enableAutolayout()
    }
    
    func hideEmtyCells() {
        tableFooterView = UIView()
    }
    
    func enableAutolayout() {
        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = 66.0
    }
    
    func reload() {
        reloadData()
    }
}
