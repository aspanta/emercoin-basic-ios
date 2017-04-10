//
//  ApiManager.swift
//  Emercoin Basic
//

import UIKit

enum APIType {
    case balance
    case info
    case transactions
    case sendCoins
    case myAddresses
    case myNewAddress
    case names
    case addName
}

class APIManager: NSObject {
    
    internal static let sharedInstance = APIManager()
    
    private var authInfo:[String:String] = [:]
    
    func addAuthInfo(at authInfo:[String:String]) {
        
        self.authInfo = authInfo
    }
    
    func login(at authInfo:[String:String], completion:@escaping (_ data: AnyObject?,_ error:NSError?) -> Void) {
        
        self.authInfo = authInfo
        
        loadInfo(completion: completion)
    }
    
    func loadInfo(completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .info)
        api.startRequest(completion: completion)
    }
    
    func loadTransactions(completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .transactions)
        api.startRequest(completion: completion)
    }
    
    func loadBalance(completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .balance)
        api.startRequest(completion: completion)
    }
    
    func sendCoins(at sendData:AnyObject, completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .sendCoins)
        
        if var params = api.object as? [String:AnyObject] {
            params["sendData"] = sendData as AnyObject?
            api.object = params as AnyObject?
        }
        
        api.startRequest(completion: completion)
    }
    
    func addName(at nameData:AnyObject, completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .addName)
        
        if var params = api.object as? [String:AnyObject] {
            params["nameData"] = nameData as AnyObject?
            api.object = params as AnyObject?
        }
        
        api.startRequest(completion: completion)
    }
    
    func loadMyAddresses(completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .myAddresses)
        api.startRequest(completion: completion)
    }
    
    func loadNames(completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .names)
        api.startRequest(completion: completion)
    }
    
    func loadMyNewAddress(completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .myNewAddress)
        api.startRequest(completion: completion)
    }
    
    func loadEmercoinCourse(completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = EmercoinCourseAPI()
        api.startRequest(completion: completion)
    }
    
    private func getApi(at type:APIType) -> BaseAPI {
        
        var api:BaseAPI = BaseAPI()
        
        switch type {
            case .balance:api = BalanceAPI()
            case .info:api = InfoAPI()
            case .transactions:api = TransactionsAPI()
            case .sendCoins:api = SendCoinsAPI()
            case .myAddresses:api = MyAddressesAPI()
            case .myNewAddress:api = AddMyAddressAPI()
            case .names:api = NamesAPI()
            case .addName:api = AddNameAPI()
        }
        
        api.object = authInfo as AnyObject?

        return api
    }
}
