//
//  AddMyAddressAPI.swift
//  EmercoinBasic
//
//  Created by Sergey Lyubeznov on 24/03/2017.
//  Copyright © 2017 Aspanta Limited. All rights reserved.
//

import UIKit

class AddMyAddressAPI: BaseAPI {

    override func parameters() -> [String : Any] {
        
        var params = super.parameters()
        let method = Constants.API.GetNewMyAddress
        params["method"] = method
        
        return params
    }
    
    override func apiDidReturnData(data: AnyObject) {
        
        if let address = data["result"] as? String  {
            super.apiDidReturnData(data: address as AnyObject)
        } else {
            super.apiDidReturnData(data: data)
        }
    }
}
