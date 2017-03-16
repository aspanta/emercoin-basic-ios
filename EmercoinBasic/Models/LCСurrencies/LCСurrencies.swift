//
//  LCСurrencies.swift
//  EmercoinOne
//

import UIKit

class LCCurrencies: NSObject {

    private var currencyList:[LCCurrency] = []
    
    override init() {
        super.init()
        
        stubContacts()
    }
    
    var currencies:[LCCurrency] {
        get {
            return currencyList
        }
    }
    
    func add(currency:LCCurrency) {
        currencyList.append(currency)
    }
    
    func remove(currency:LCCurrency) {
        currencyList.remove(object: currency)
    }
    
    func removeAll() {
        currencyList.removeAll()
    }
    
    func stubContacts() {
        
        let curren1 = LCCurrency(name: "USD", amount: 70.78, available: 10.17, inOrders: 60.61)
        let curren2 = LCCurrency(name: "EUR", amount: 0, available: 10.17, inOrders: 60.61)
        let curren3 = LCCurrency(name: "RUR", amount: 4633, available: 10.17, inOrders: 60.61)
        
        add(currency: curren1)
        add(currency: curren2)
        add(currency: curren3)
    }

}
