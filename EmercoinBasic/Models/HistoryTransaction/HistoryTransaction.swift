//
//  HistoryTransaction.swift
//  EmercoinBasic
//

import UIKit
import ObjectMapper
import RealmSwift

enum TransactionDirection:String {
    case incoming = "receive"
    case outcoming = "send"
}

class HistoryTransaction:Object, Mappable {
    
    dynamic var amount:Double = 0
    dynamic var fee:Double = 0
    dynamic var vout:Int = 0
    dynamic var date = ""
    dynamic var dateFull = ""
    dynamic var blockheight = 0
    dynamic var blockhash = ""
    dynamic var transactionId = ""
    dynamic var isConfirmed = true
    dynamic var confirmations:Int = 0 {
        didSet {
            isConfirmed = confirmations > 0
        }
    }
    dynamic var type = ""
    dynamic var address = ""
    dynamic var category = ""
    
    dynamic var timereceived:TimeInterval = 0 {
        didSet {
            let date = Date.init(timeIntervalSince1970: timereceived)
            self.date = date.transactionStringDate()
            self.dateFull = date.transactionStringDateFull()
        }
    }
    
    func direction() -> TransactionDirection {
        return TransactionDirection(rawValue: category)!
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        timereceived <- map["timereceived"]
        amount <- map["amount"]
        address <- map["address"]
        category <- map["category"]
        blockheight <- map["blockheight"]
        blockhash <- map["blockhash"]
        transactionId <- map["txid"]
        fee <- map["fee"]
        vout <- map["vout"]
        confirmations <- map["confirmations"]
    }
}
