//
//  LCСurrency.swift
//  EmercoinOne
//

import UIKit

class LCCurrency: NSObject {

    var name:String
    var amount:Double
    var available:Double
    var inOrders:Double
    
    init(name:String, amount:Double, available:Double, inOrders:Double) {

        self.name = name
        self.amount = amount
        self.available = available
        self.inOrders = inOrders
    }
    
}
