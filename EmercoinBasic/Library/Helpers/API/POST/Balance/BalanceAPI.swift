//
//  BalanceAPI.swift
//  EmercoinBasic
//

import UIKit

class BalanceAPI: BaseAPI {

    override func method() -> HTTPMethod {
        return .post
    }
    
    override func parameters() -> [String : Any] {
        
        var param = super.parameters()
        let method = Constants.API.GetBalance
        param["method"] = method
        
        return param
    }
    
    override func apiDidReturnData(data: AnyObject) {
        
        if let balance = data["result"] as? Double  {
            super.apiDidReturnData(data: balance as AnyObject)
        } else {
            super.apiDidReturnData(data: data)
        }
    }
}
