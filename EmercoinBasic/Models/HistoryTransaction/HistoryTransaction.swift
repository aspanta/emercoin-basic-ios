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
    
    @objc dynamic var amount:Double = 0
    @objc dynamic var fee:Double = 0
    @objc dynamic var vout:Int = 0
    @objc dynamic var date = ""
    @objc dynamic var dateFull = ""
    @objc dynamic var blockheight = 0
    @objc dynamic var blockhash = ""
    @objc dynamic var transactionId = ""
    @objc dynamic var isConfirmed = true
    @objc dynamic var confirmations:Int = 0 {
        didSet {
            isConfirmed = confirmations > 0
        }
    }
    @objc dynamic var type = ""
    @objc dynamic var address = ""
    @objc dynamic var category = ""
    
    @objc dynamic var timereceived:TimeInterval = 0 {
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
