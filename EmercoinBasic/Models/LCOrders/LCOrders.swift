//
//  LCOrders.swift
//  EmercoinOne
//

import UIKit

class LCOrders: NSObject {

    private var orderList:[LCOrder] = []
    
    var date:String? = ""
    
    override init() {
        super.init()
        
    }
    
    var orders:[LCOrder] {
        get {
            return orderList
        }
    }
    
    func add(order:LCOrder) {
        orderList.append(order)
    }
    
    func remove(order:LCOrder) {
        orderList.remove(object: order)
    }
    
    func removeAll() {
        orderList.removeAll()
    }
    
    func stubOrders(date:String) {
        
        self.date = date
        
        let coin = Coin()
        coin.amount = arc4random_uniform(2) == 1 ? 100 : 50
        coin.type = .emercoin
        
        let coin2 = Coin()
        coin2.amount = arc4random_uniform(2) == 1 ? 0.0004 : 0.0002
        coin2.type = .bitcoin
        
        let time = arc4random_uniform(2) == 1 ? "14:22" : "16:37"
        let open = arc4random_uniform(2) == 1
        let status = open ? "Open" : arc4random_uniform(2) == 1 ? "Performed on 90%" : "Close"
        
        let order1 = LCOrder(date: date, time: time, open: open, coinFirst: coin, coinSecond: coin2, status: status)
        let order2 = LCOrder(date: date, time: time, open: open, coinFirst: coin, coinSecond: coin2, status: status)
        order1.isDeclared = arc4random_uniform(2) == 1
        
        add(order: order1)
        add(order: order2)
    
    }
}
