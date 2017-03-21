//
//  HistoryTransactionViewModel.swift
//  EmercoinBasic
//

import UIKit

class HistoryTransactionViewModel {

    var date:String = ""
    var address:String = ""
    var amount:String = ""
    var sign:String = "EMC"
    var imageTransactionDirection:UIImage? = nil
    
    init(historyTransaction:HistoryTransaction) {
        
        self.date = historyTransaction.date ?? ""
        self.address = historyTransaction.address ?? ""
        self.amount = String(format:"%0.2f",historyTransaction.amount)
        
        let isIncoming = historyTransaction.typeOperation == .incoming
        
        let image = isIncoming ? "oper_rightarrow_icon" : "oper_leftarrow_icon"
        
        self.imageTransactionDirection = UIImage(named: image)
    }
}
