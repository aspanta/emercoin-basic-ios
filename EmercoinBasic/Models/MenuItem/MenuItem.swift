//
//  MenuItem.swift
//  EmercoinOne
//
//  Created by Sergey Lyubeznov on 15/02/2017.
//  Copyright © 2017 Aspanta. All rights reserved.
//

import UIKit

class MenuItem {
    
    var title:String
    var image:String
    var subTitles:[String] = []

    
    init(title:String, image:String) {
        self.title = title
        self.image = image
    }
}
