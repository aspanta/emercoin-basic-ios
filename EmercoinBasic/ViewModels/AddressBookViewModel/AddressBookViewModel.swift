//
//  AddressBookViewModel.swift
//  EmercoinOne
//

import UIKit
import RxSwift
import RxCocoa

class AddressBookViewModel {

    let bitColor = Constants.Controllers.Send.HeaderView.BitcoinColor
    let emerColor = Constants.Controllers.Send.HeaderView.EmercoinColor
    
    let disposeBag = DisposeBag()
    
    var coinImage = PublishSubject<UIImage>()
    var statusColor: Observable<UIColor>!
    var titleColor:UIColor?
    var addImage:UIImage?
    
    var coinType:CoinType = .bitcoin {
        didSet {
            
            let isBitcoin = coinType == .bitcoin
            
            let imageName = isBitcoin ? Constants.Controllers.Send.HeaderView.BitcoinImage :
                Constants.Controllers.Send.HeaderView.EmercoinImage
            
            let addImageName = isBitcoin ? "book_add_bit_icon" : "book_add_emc_icon"
            addImage = UIImage(named: addImageName)

            coinImage.onNext(UIImage(named: imageName)!)
            
        }
    }
    
    init() {
        
        statusColor = coinImage.asObserver()
            .map({ string in
                let isBitcoin = self.coinType == .bitcoin
                let colorHEX = isBitcoin ? Constants.Controllers.Send.StatusColor.BitcoinColor :
                    Constants.Controllers.Send.StatusColor.EmercoinColor
                let colorHEX2 = isBitcoin ? self.bitColor : self.emerColor
                self.titleColor = UIColor(hexString: colorHEX2)
                return UIColor(hexString: colorHEX)
            })
    }
}
