
//
//  LCOrderViewModel.swift
//  EmercoinOne
//

import UIKit

class LCOrderViewModel {
    
    var time:String
    var coiFirst:String
    var coinSecondAmount:String
    var coindSecondSign:String
    var status:String
    var isOpen:Bool
    var color:UIColor
    var showStatus:Bool
    var isDeclared:Bool = false
    
    init(order:LCOrder, showStatus:Bool) {
        time = order.time
        coiFirst = String(format:"%@ %@", order.coinFirst.stringAmount(), (order.coinFirst.sign ?? ""))
        coinSecondAmount = String(format:"%0.5f",order.coinSecond.amount ?? 0)
        coindSecondSign = order.coinSecond.sign ?? ""
        status = order.status
        isOpen = order.isOpen
        
        let hexColor = isOpen ? "2b7582" : "da4079"
        
        color = UIColor(hexString: hexColor)
        
        isDeclared = order.isDeclared
        self.showStatus = showStatus
    }
}
