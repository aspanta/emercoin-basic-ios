//
//  LCOrder.swift
//  EmercoinOne
//

import UIKit

class LCOrder: NSObject {

    var date:String
    var time:String
    var isOpen:Bool
    var coinFirst:Coin
    var coinSecond:Coin
    var status:String
    var isDeclared:Bool = false
    
    required init(date:String, time:String, open:Bool, coinFirst:Coin, coinSecond:Coin, status:String) {
        self.date = date
        self.time = time
        self.isOpen = open
        self.coinFirst = coinFirst
        self.coinSecond = coinSecond
        self.status = status
    }
}
