//
//  CoinsOperationViewModel.swift
//  EmercoinOne
//


import UIKit
import RxSwift
import RxCocoa

class CoinsOperationViewModel {
    
    let bitColor = Constants.Controllers.Send.HeaderView.BitcoinColor
    let emerColor = Constants.Controllers.Send.HeaderView.EmercoinColor
    
    let disposeBag = DisposeBag()
    var wallet:Wallet
    
    var coinTitle = PublishSubject<String>()
    var coinImage = PublishSubject<UIImage>()
    var addImage:UIImage?
    var coinCourseTitle = PublishSubject<NSAttributedString>()
    var headerColor: Observable<UIColor>!
    var statusColor:UIColor?
    var mainColor:UIColor?
    var coinAmount = PublishSubject<String>()
    var coinSign:String?
    var exchangeRate = PublishSubject<String>()
    var getCoins = PublishSubject<String>()
    var exchangeAmount:Double = 1.0 {
        didSet {
            updateExchangeCoins()
        }
    }
    
    var coinType:CoinType = .bitcoin {
        didSet {
            
            let isBitcoin = coinType == .bitcoin
            let title = isBitcoin ? wallet.bitcoin.name : wallet.emercoin.name
            let imageName = isBitcoin ? Constants.Controllers.Send.HeaderView.BitcoinImage :
                Constants.Controllers.Send.HeaderView.EmercoinImage
            let courseTitle = isBitcoin ? wallet.bitcoin.exchangeAttributedString(color: .white) :
                wallet.emercoin.exchangeAttributedString(color: .white)
            
            let amount = isBitcoin ? wallet.bitcoin.amount : wallet.emercoin.amount
            coinSign = isBitcoin ? wallet.bitcoin.sign : wallet.emercoin.sign
            
            let addImageName = isBitcoin ? "book_add_bit_icon" : "book_add_emc_icon"
            addImage = UIImage(named: addImageName)
            
            coinTitle.onNext(title!)
            coinImage.onNext(UIImage(named: imageName)!)
            coinCourseTitle.onNext(courseTitle)
            coinAmount.onNext(String(format:"%0.2f",amount!))
            
            updateExchangeCoins()
        }
    }
    
    private func updateExchangeCoins() {
    
        let isBitcoin = coinType == .bitcoin
        let exhangeRateValue = isBitcoin ? wallet.exchangeRateEmercoinInBitcoin() : wallet.exchangeRateBitcoinInEmercoin()
        let exchangeAmountValue = (isBitcoin ? wallet.emcInBit  : wallet.bitInEmc) * exchangeAmount
        
        let getString = String(format:"Get: %0.4f %@",exchangeAmountValue,(isBitcoin ? wallet.emercoin.sign : wallet.bitcoin.sign)!)
        
        exchangeRate.onNext(exhangeRateValue)
        getCoins.onNext(getString)
    }
    
    init() {
        
        self.wallet = AppManager.sharedInstance.wallet
        
        headerColor = coinTitle.asObserver()
            .map({ string in
                let isBitcoin = self.coinType == .bitcoin
                let colorHEX = isBitcoin ? self.bitColor : self.emerColor
                let colorHEX2 = isBitcoin ? Constants.Controllers.Send.StatusColor.BitcoinColor :
                    Constants.Controllers.Send.StatusColor.EmercoinColor
                self.statusColor = UIColor(hexString: colorHEX2)
                self.mainColor = UIColor(hexString: colorHEX)
                return self.mainColor!
            })
    }
}
