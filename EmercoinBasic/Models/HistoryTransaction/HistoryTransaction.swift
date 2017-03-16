//
//  HistoryTransaction.swift
//  EmercoinOne
//

import UIKit

enum TransactionDirection {
    case incoming
    case outcoming
}

class HistoryTransaction: NSObject {
    
    var coin:Coin
    var date:String
    var address:String
    var typeOperation:TransactionDirection
    
    init(coin:Coin, date:String, address:String) {
        self.coin = coin
        self.date = date
        self.address = address
        self.typeOperation = (arc4random_uniform(2) > 0) ? .incoming : .outcoming
    }

}
