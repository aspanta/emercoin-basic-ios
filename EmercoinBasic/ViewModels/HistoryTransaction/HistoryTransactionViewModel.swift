//
//  HistoryTransactionViewModel.swift
//  EmercoinOne
//

import UIKit

class HistoryTransactionViewModel {

    var date:String = ""
    var address:String = ""
    var amount:String = ""
    var sign:String = ""
    var imageTransactionDirection:UIImage? = nil
    
    init(historyTransaction:HistoryTransaction) {
        
        self.date = historyTransaction.date
        self.address = historyTransaction.address
        self.amount = historyTransaction.coin.stringAmount()
        
        guard let sign = historyTransaction.coin.sign else {
            return
        }
        self.sign = sign
        
        let isIncoming = historyTransaction.typeOperation == .incoming
        
        let image = isIncoming ? "oper_rightarrow_icon" : "oper_leftarrow_icon"
        
        self.imageTransactionDirection = UIImage(named: image)
    }
}
