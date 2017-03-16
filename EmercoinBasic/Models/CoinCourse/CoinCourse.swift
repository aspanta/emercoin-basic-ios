//
//  CoinCourse.swift
//  EmercoinOne
//

import UIKit

enum CoinCourseType {
    case bitcoin
    case livecoin
    case xbtce
}

class CoinCourse: NSObject {
    
    var sell:Double?
    var buy:Double?
    var type:CoinCourseType = .bitcoin
    var isWorking = true
    
    init(sell:Double, buy:Double, type:CoinCourseType, working:Bool) {
        self.sell = sell
        self.buy = buy
        self.type = type
        self.isWorking = working
    }
    
    
    func stringSell() -> String {
        return String(format:"%0.5f",sell!)
    }
    
    func stringBuy() -> String {
        return String(format:"%0.5f",buy!)
    }
    
}
