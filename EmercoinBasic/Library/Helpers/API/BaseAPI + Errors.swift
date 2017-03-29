//
//  BaseAPI + Errors.swift
//  EmercoinBasic
//

import Foundation

extension BaseAPI {
    
    func formattedError(at error:Error) -> NSError {
        
        var text = ""
        
        let tempError = error as NSError
        
        let message = tempError.domain
        
        if message.contains("Unauthorized") {
            text = "Authentication failed"
        } else if message.contains("Insufficient funds") {
            text = "Insufficient funds"
        } else if message.contains("Could not connect") {
            text = "Could not connect to the server"
        } else {
            text = message.replacingOccurrences(of: ".", with: "")
        }
    
        let newError = NSError(domain: text, code: -1, userInfo: nil)
        
        return newError
        
    }
    
}
