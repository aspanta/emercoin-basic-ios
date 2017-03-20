//
//  Protocols.swift
//  VKApp
//
//  Created by Sergey Lyubeznov on 26/01/2017.
//  Copyright © 2017 Sergey Lyubeznov. All rights reserved.
//

import UIKit

protocol Observer {
    
    func objectDidChange(object:AnyObject)
}

protocol Observable {
    
    var observers:[ObserverObject] {get set}
    
    func addObserver(observer:ObserverObject)
    func removeObserver(observer:ObserverObject)
    func removeAllObservers()
    
}
