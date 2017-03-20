//
//  ApiManager.swift
//  Emercoin Basic
//

import UIKit

class APIManager: NSObject {
    
    internal static let sharedInstance = APIManager()
    
    private var loginInfo:[String:String] = [:]
    
    func login(at loginInfo:[String:String], completion:@escaping (_ data: AnyObject?,_ error:Error?) -> Void) {
        
        self.loginInfo = loginInfo
        
        loadInfo(completion: completion)
    }
    
    func loadInfo(completion:@escaping (_ data: AnyObject?, _ error:Error?) -> Void) {
        
        let api = InfoAPI()
        api.object = loginInfo as AnyObject?
        
        api.startRequest { (data, error) in
            
            if error == nil {
                completion(data!, nil)
            } else {
                completion(nil,error!)
            }
        }
    }
}
