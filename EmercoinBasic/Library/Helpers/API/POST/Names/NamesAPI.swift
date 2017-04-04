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
        
        if let records = Mapper<Record>().mapArray(JSONArray: data["result"] as! [[String:AnyObject]]) {
            super.apiDidReturnData(data: records as AnyObject)
        } else {
            super.apiDidReturnData(data: data)
        }
    }
}
