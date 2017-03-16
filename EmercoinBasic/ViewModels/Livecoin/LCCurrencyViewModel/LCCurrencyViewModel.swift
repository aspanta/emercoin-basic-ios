//
//  LCCurrencyViewModel.swift
//  EmercoinOne
//

import UIKit

class LCCurrencyViewModel {

    var name:String
    var amount:String
    var available:String
    var inOrders:String
    
    init(currency:LCCurrency) {
        name = currency.name
        amount = String(currency.amount)
        available = String(currency.available)
        inOrders = String(currency.inOrders)
    }
}
