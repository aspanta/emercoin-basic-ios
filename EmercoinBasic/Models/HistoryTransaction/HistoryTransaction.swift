//
//  HistoryTransaction.swift
//  EmercoinBasic
//

import UIKit
import ObjectMapper

enum TransactionDirection:String {
    case incoming = "receive"
    case outcoming = "send"
}

class HistoryTransaction: BaseModel {
    
    var amount:Double = 0
    var date:String?
    var address:String?
    var typeOperation:TransactionDirection = .incoming
    var timereceived:TimeInterval = 0 {
        didSet {
            date = Date.init(timeIntervalSince1970: timereceived).transactionStringDate()
        }
    }
    
    var category:String? {
        didSet {
            typeOperation = TransactionDirection(rawValue: category ?? "")!
        }
    }
    
    override func mapping(map: Map) {
        
        amount <- map["amount"]
        address <- map["address"]
        timereceived <- map["timereceived"]
        category <- map["category"]
    }

}
