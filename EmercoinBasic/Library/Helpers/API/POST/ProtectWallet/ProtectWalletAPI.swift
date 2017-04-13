//
//  ProtectWalletAPI.swift
//  EmercoinBasic
//

import UIKit

class ProtectWalletAPI: BaseAPI {
    
    override var timeRequest:Double {
        return 120
    }

    override func parameters() -> [String : Any] {
        
        var params = super.parameters()
        let method = Constants.API.ProtectWallet
        params["method"] = method
        
        guard let data = object as? [String:AnyObject] else {
            return params
        }
        
        if let protectData = data["protectData"] {
            params["params"] = protectData
        }
        
        return params
    }
    
    override func apiDidReturnData(data: AnyObject) {
        
        if let result = data["result"] as? String  {
            let success = result.length > 0
            super.apiDidReturnData(data: success as AnyObject)
        } else {
            super.apiDidReturnData(data: data)
        }
    }
    
}
