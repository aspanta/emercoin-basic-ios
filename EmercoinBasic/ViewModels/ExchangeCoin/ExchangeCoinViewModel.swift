//
//  ExchangeCoinViewModel.swift
//  EmercoinOne
//
//  Created by Sergey Lyubeznov on 22/02/2017.
//  Copyright © 2017 Aspanta. All rights reserved.
//

import UIKit

class ExchangeCoinViewModel {

    var sell:String = ""
    var title:String = ""
    var buy:String = ""
    var coinImage:UIImage? = nil
    var isWorking = true
    
    init(coinCourse:CoinCourse) {
        
        self.sell = coinCourse.stringSell()
        self.buy = coinCourse.stringBuy()
        self.isWorking = coinCourse.isWorking
        
        var image:String? = nil
        var title = ""
        
        switch coinCourse.type {
            case .bitcoin:  image = "ex_bit_icon"; title = "BITCOIN"
            case .livecoin: image = "ex_live_icon"; title = "LIVECOIN"
            case .xbtce:    image = "ex_xbtce_icon"; title = "XBTCE"
        }
        
        self.title = title
        
        if image != nil {
            self.coinImage = UIImage(named: image!)
        }
    }
}
