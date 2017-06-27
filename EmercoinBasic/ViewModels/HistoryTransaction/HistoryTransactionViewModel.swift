//
//  HistoryTransactionViewModel.swift
//  EmercoinBasic
//

import UIKit

class HistoryTransactionViewModel {

    var date = ""
    var dateFull = ""
    var address = ""
    var amount = ""
    var sign = "EMC"
    var category = ""
    var fee = ""
    var vout = ""
    var blockheight = ""
    var transactionId = ""
    var isConfirmed = true
    var imageTransactionDirection:UIImage? = nil
    
    init(historyTransaction:HistoryTransaction) {
        
        self.date = historyTransaction.date
        self.dateFull =  historyTransaction.dateFull
        self.address = historyTransaction.address
        self.amount = String.dropZeroLast(at: String.coinFormat(at: historyTransaction.amount))
        self.fee = String.coinFormat(at: historyTransaction.fee)
        self.vout = String(historyTransaction.vout)
        
        self.blockheight = historyTransaction.isConfirmed ? historyTransaction.blockhash : "unconfirmed"
        self.transactionId = historyTransaction.transactionId
        self.isConfirmed = historyTransaction.isConfirmed
        
        let isIncoming = historyTransaction.direction() == .incoming
        
        category = isIncoming ? "Receive" : "Send"
        
        let image = isIncoming ? "oper_rightarrow_icon" : "oper_leftarrow_icon"
        self.imageTransactionDirection = UIImage(named: image)
    }
}
