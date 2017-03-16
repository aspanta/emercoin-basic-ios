//
//  TabBarObject.swift
//  EmercoinOne
//
//  Created by Sergey Lyubeznov on 14/02/2017.
//  Copyright © 2017 Aspanta. All rights reserved.
//

import UIKit

protocol TabBarObjectInfo {
    
    var tabBarObject:TabBarObject? {get set}
}

class TabBarObject {
    
    var title:String
    var imageName:String
    
    init(title:String, imageName:String) {
        self.title = title
        self.imageName = imageName
    }
}
