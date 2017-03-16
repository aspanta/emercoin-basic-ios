//
//  LCPutOrderViewModel.swift
//  EmercoinOne
//

import UIKit

class LCPutOrderViewModel {
    
    var coiFirst:String
    var coinSecondAmount:String
    var coindSecondSign:String
    var color:UIColor
    var isDeclared:Bool
    
    init(order:LCOrder) {
        
        coiFirst = String(format:"%@ %@", order.coinFirst.stringAmount(), (order.coinFirst.sign ?? ""))
        coinSecondAmount = String(format:"%0.5f",order.coinSecond.amount ?? 0)
        coindSecondSign = order.coinSecond.sign ?? ""
        
        isDeclared = order.isDeclared
        
        let hexColor = isDeclared ? "2b7582" : "000000"
        
        color = UIColor(hexString: hexColor)
    }
}
