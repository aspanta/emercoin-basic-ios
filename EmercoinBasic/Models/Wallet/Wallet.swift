//
//  Wallet.swift
//  EmercoinOne
//

import UIKit
import ObjectMapper

class Wallet:Mappable {
    
    var emercoin:Coin = {
        let emCoin = Coin()
        emCoin.name = "EMERCOIN"
        emCoin.amount = 0.0
        emCoin.image = "emer_icon_1"
        emCoin.sign = "EMC"
        emCoin.color = Constants.Colors.Coins.Emercoin
        return emCoin
    }()
    
    var emcInBit:Double = 100.0
    var bitInEmc:Double = 0.0001
    var balance:Double = 0.0 {
        didSet{
            emercoin.amount = balance
        }
    }
    
    private var loginInfo:[String:String] = [:]
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        balance <- map["balance"]
    }
    
    func exchangeRateBitcoinInEmercoin() -> String {
        return String(format:"1 EMC = %0.4f BTC",bitInEmc)
    }
    
    func exchangeRateEmercoinInBitcoin() -> String {
        return String(format:"1 BTC = %0.4f EMC",emcInBit)
    }
    
    func stubMyAddresses() -> [String] {
        return [""]
    }
    
    func loadInfo() {
        
    }

}
