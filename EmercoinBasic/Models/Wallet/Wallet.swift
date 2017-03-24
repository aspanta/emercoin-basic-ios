//
//  Wallet.swift
//  EmercoinBasic
//

import UIKit
import ObjectMapper
import RxCocoa
import RxSwift

class Wallet:BaseModel {
    
    var success = PublishSubject<Bool>()
    var error = PublishSubject<NSError>()
    var isActivityIndicator = PublishSubject<Bool>()
    
    var emercoin:Coin = {
        let emCoin = Coin()
        emCoin.name = "EMERCOIN"
        emCoin.amount = 0.0
        emCoin.image = "emer_icon_1"
        emCoin.sign = "EMC"
        emCoin.color = Constants.Colors.Coins.Emercoin
        return emCoin
    }()
    
    init(amount:Double) {
        emercoin.amount = amount
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    var balance:Double = 0.0 {
        didSet{
            emercoin.amount = balance
              success.onNext(true)
        }
    }
    
    private var loginInfo:[String:String] = [:]
    
    override func mapping(map: Map) {
        balance <- map["balance"]
    }
    
    func stubMyAddresses() -> [String] {
        return [""]
    }
    
    func loadBalance() {
     
        APIManager.sharedInstance.loadBalance {[weak self] (data, error) in
            self?.isActivityIndicator.onNext(false)
            if error != nil {
                self?.error.onNext(error!)
            } else {
                if let balance = data as? Double {
                    self?.balance = balance
                }
            }
        }
    }
}
