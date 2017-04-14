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
    var locked = PublishSubject<Bool>()
    
    var emercoin:Coin = {
        let emCoin = Coin()
        emCoin.name = "EMERCOIN"
        emCoin.amount = 0.0
        emCoin.image = "emer_icon_1"
        emCoin.sign = "EMC"
        emCoin.color = Constants.Colors.Coins.Emercoin
        return emCoin
    }()
    
    var amountData:AnyObject?
    
    var isLocked = false
    var isProtected = false
    var isMintonly = false
    
    private var unlockedUntil = 1 {
        didSet {
            isLocked = unlockedUntil == 0
        }
    }
    
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
            checkLock()
        }
    }
    
    override func mapping(map: Map) {
        
        isMintonly <- map["mintonly"]
        unlockedUntil <- map["unlocked_until"]
        isProtected <- map["encrypted"]
        balance <- map["balance"]
        
    }
    
    private func checkLock() {
        
        let lock = isLocked
        locked.onNext(lock)
    }
    
    
    func loadInfo(completion:((Void) -> Void)? = nil) {
        
        APIManager.sharedInstance.loadInfo{[weak self] (data, error) in
            
            self?.isActivityIndicator.onNext(false)
            if error != nil {
                self?.error.onNext(error!)
            } else {
                
                if let wallet = data as? Wallet {
                    self?.isLocked = wallet.isLocked
                    self?.isProtected = wallet.isProtected
                    self?.isMintonly = wallet.isMintonly
                    self?.balance = wallet.balance
                }
            }
            if completion != nil {
                completion!()
            }
        }
        loadCourse()
    }
    
    func l1oadBalance() {
     
        APIManager.sharedInstance.loadBalance {[weak self] (data, error) in
            
            self?.isActivityIndicator.onNext(false)
            if let error = error {
                self?.error.onNext(error)
            } else {
                AppManager.sharedInstance.myAddressBook.load()
                if let balance = data as? Double {
                    self?.balance = balance
                }
            }
        }
        loadCourse()
    }
    
    func loadCourse() {
        APIManager.sharedInstance.loadEmercoinCourse {[weak self] (data, error) in
            if let priceUSD = Double(data as! String) {
                self?.emercoin.priceUSD = priceUSD
                self?.success.onNext(true)
            }
        }
    }
}
