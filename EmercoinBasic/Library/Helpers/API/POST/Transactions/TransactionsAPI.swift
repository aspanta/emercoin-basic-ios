//
//  TransactionsAPI.swift
//  EmercoinBasic
//

import UIKit
import ObjectMapper

class TransactionsAPI: BaseAPI {

    override func method() -> HTTPMethod {
        return .post
    }
    
    override func parameters() -> [String : Any] {
        
        var param = super.parameters()
        let method = Constants.API.GetTransactions
        param["method"] = method
        
        return param
    }
    
    override func apiDidReturnData(data: AnyObject) {
        
        if let transactions = Mapper<HistoryTransaction>().mapArray(JSONArray: data["result"] as! [[String:AnyObject]]) {
            super.apiDidReturnData(data: transactions as AnyObject)
        } else {
            super.apiDidReturnData(data: data)
        }
    }
}
