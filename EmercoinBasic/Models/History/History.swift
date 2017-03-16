//
//  History.swift
//  EmercoinOne
//

import UIKit

class History: NSObject {

    private var transactionList:[HistoryTransaction] = []
    
    var cointType:CoinType?
    
    var transactions:[HistoryTransaction] {
        get {
            return transactionList.filter({ (item) -> Bool in
                item.coin.type == cointType
            })
        }
    }
    
    func add(transaction:HistoryTransaction) {
        transactionList.append(transaction)
    }
    
    func remove(transaction:HistoryTransaction) {
        transactionList.remove(object: transaction)
    }
    
    func removeAll() {
        transactionList.removeAll()
    }
    
    func stubContacts(cointType:CoinType) {
        
        let coin1 = Coin()
        coin1.amount = 100
        coin1.type = cointType
        
        let coin2 = Coin()
        coin2.amount = 200
        coin2.type = cointType
        
        let coin3 = Coin()
        coin3.amount = 300
        coin3.type = cointType
        
        let coin4 = Coin()
        coin4.amount = 400
        coin4.type = cointType
        
        let coin5 = Coin()
        coin5.amount = 500
        coin5.type = cointType
        
        let trans1 = HistoryTransaction(coin: coin1, date: "28 .04. 2004", address: "1YhdkU125423kdf58RtEb6")
        let trans2 = HistoryTransaction(coin: coin2, date: "27 .04. 2004", address: "1YhdkU125423kdf58RtEb6")
        let trans3 = HistoryTransaction(coin: coin3, date: "26 .04. 2004", address: "1YhdkU125423kdf58RtEb6")
        let trans4 = HistoryTransaction(coin: coin4, date: "25 .04. 2004", address: "1YhdkU125423kdf58RtEb6")
        let trans5 = HistoryTransaction(coin: coin5, date: "24 .04. 2004", address: "1YhdkU125423kdf58RtEb6")
        
        add(transaction: trans1)
        add(transaction: trans2)
        add(transaction: trans3)
        add(transaction: trans4)
        add(transaction: trans5)
        
    }
}
