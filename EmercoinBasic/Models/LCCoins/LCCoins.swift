//
//  LCCoins.swift
//  EmercoinOne
//

import UIKit

class LCCoins: LCCurrencies {
    
    override init() {
        super.init()
        
        //stubContacts()
    }

    override func stubContacts() {
        
        let curren1 = LCCurrency(name: "BTC", amount: 3.86567, available: 10.17, inOrders: 60.61)
        let curren2 = LCCurrency(name: "LTC", amount: 4.55, available: 10.17, inOrders: 60.61)
        let curren3 = LCCurrency(name: "DASH", amount: 783.73, available: 10.17, inOrders: 60.61)
        
        add(currency: curren1)
        add(currency: curren2)
        add(currency: curren3)
        
    }
}
