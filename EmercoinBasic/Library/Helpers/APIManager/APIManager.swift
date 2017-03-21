//
//  ApiManager.swift
//  Emercoin Basic
//

import UIKit

enum APIType {
    case balance
    case info
    case transactions
}

class APIManager: NSObject {
    
    internal static let sharedInstance = APIManager()
    
    private var loginInfo:[String:String] = [:]
    
    func login(at loginInfo:[String:String], completion:@escaping (_ data: AnyObject?,_ error:Error?) -> Void) {
        
        self.loginInfo = loginInfo
        
        loadInfo(completion: completion)
    }
    
    func loadInfo(completion:@escaping (_ data: AnyObject?, _ error:Error?) -> Void) {
        
        let api = getApi(at: .info)
        api.startRequest(completion: completion)
    }
    
    func loadTransactions(completion:@escaping (_ data: AnyObject?, _ error:Error?) -> Void) {
        
        let api = getApi(at: .transactions)
        api.startRequest(completion: completion)
    }
    
    func loadBalance(completion:@escaping (_ data: AnyObject?, _ error:Error?) -> Void) {
        
        let api = getApi(at: .balance)
        api.startRequest(completion: completion)
    }
    
    private func getApi(at type:APIType) -> BaseAPI {
        
        var api:BaseAPI = BaseAPI()
        
        switch type {
            case .balance:api = BalanceAPI()
            case .info:api = InfoAPI()
            case .transactions:api = TransactionsAPI()
        }
        
        api.object = loginInfo as AnyObject?

        return api
    }
}
