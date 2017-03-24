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
}

class APIManager: NSObject {
    
    internal static let sharedInstance = APIManager()
    
    private var loginInfo:[String:String] = [:]
    
    func addLoginInfo(at loginInfo:[String:String]) {
        
        self.loginInfo = loginInfo
    }
    
    func login(at loginInfo:[String:String], completion:@escaping (_ data: AnyObject?,_ error:NSError?) -> Void) {
        
        self.loginInfo = loginInfo
        
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
    
    func loadMyAddresses(completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .myAddresses)
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
        }
        
        api.object = loginInfo as AnyObject?

        return api
    }
}
