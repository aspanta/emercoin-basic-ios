//
//  NamesAPI.swift
//  EmercoinBasic
//

import UIKit
import ObjectMapper

class NamesAPI: BaseAPI {

    override func parameters() -> [String : Any] {
        
        var params = super.parameters()
        let method = Constants.API.GetNames
        params["method"] = method
        
        return params
    }
    
    override func apiDidReturnData(data: AnyObject) {
        
        if let result = data["result"] {
            
                if let names = Mapper<Record>().mapArray(JSONObject:result ) {
                    super.apiDidReturnData(data: names as AnyObject)
                }
        }
         else {
            super.apiDidReturnData(data: data)
        }
    }
}
