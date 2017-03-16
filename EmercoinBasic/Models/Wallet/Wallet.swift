//
//  Wallet.swift
//  EmercoinOne
//
//  Created by Sergey Lyubeznov on 16/02/2017.
//  Copyright © 2017 Aspanta. All rights reserved.
//

import UIKit

class Wallet {
    
    var bitcoin:Coin
    var emercoin:Coin
    
    var emcInBit:Double = 100.0
    var bitInEmc:Double = 0.0001
    
    init() {
        
        let emCoin = Coin()
        emCoin.name = "EMERCOIN"
        emCoin.amount = 10
        emCoin.image = "emer_icon_1"
        emCoin.sign = "EMC"
        emCoin.color = Constants.Colors.Coins.Emercoin
        emCoin.type = .emercoin
        
        let  bCoin = Coin()
        bCoin.name = "BITCOIN"
        bCoin.amount = 1.0
        bCoin.image = "bit_icon_1"
        bCoin.sign = "BTC"
        bCoin.color = Constants.Colors.Coins.Bitcoin
        bCoin.type = .bitcoin
        
        self.bitcoin = bCoin
        self.emercoin = emCoin

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

}
