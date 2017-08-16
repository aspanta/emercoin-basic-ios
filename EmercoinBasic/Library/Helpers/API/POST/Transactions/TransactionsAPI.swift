//
//  TransactionsAPI.swift
//  EmercoinBasic
//

import UIKit
import ObjectMapper

let maxTransactions = 100

class TransactionsAPI: BaseAPI {
    
    override func parameters() -> [String : Any] {
        
        var param = super.parameters()
        let method = Constants.API.GetTransactions
        param["method"] = method
        param["params"] = ["",maxTransactions,0,true]
        return param
    }
    
    override func apiDidReturnData(data: AnyObject) {
        
        if let result = data["result"] {
            if let transactions = Mapper<HistoryTransaction>().mapArray(JSONObject: result) {
                super.apiDidReturnData(data: transactions as AnyObject)
            }
        }
    }
}
