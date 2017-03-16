
//
//  Date + Utils.swift
//  VKApp
//
//  Created by Sergey Lyubeznov on 24/01/2017.
//  Copyright © 2017 Sergey Lyubeznov. All rights reserved.
//

import UIKit

extension Date {
    
    func stringDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dateString = dateFormatter.string(from:self)
        return dateString
    }
}


