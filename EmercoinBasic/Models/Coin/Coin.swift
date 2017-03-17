//
//  Coin.swift
//  EmercoinOne
//
import UIKit

class Coin {
    
    var name:String?
    var amount:Double?
    var image:String?
    var sign:String?
    var color:String?
    var inUSD:Double? = 1.4

    func stringAmount() -> String {
        return String(format:"%0.2f",amount ?? 0)
    }
    
    func coinInUSD() -> Double {
        return amount! * inUSD!
    }
    
    func exchangeAttributedString(color:UIColor? = nil) -> NSAttributedString {
        
        let amountAttributes = [NSForegroundColorAttributeName: color ?? .gray, NSFontAttributeName:UIFont(name: "Roboto-Medium", size: 15)]
        
        let otherAttributes = [NSForegroundColorAttributeName: color ?? .lightGray, NSFontAttributeName:UIFont(name: "Roboto-Light", size: 15)]
        
        let countInUsd = String(format:"%0.1f",coinInUSD())
        
        let part1 = NSMutableAttributedString(string: "~"+countInUsd, attributes: amountAttributes)
        let part2 = NSMutableAttributedString(string: " USD", attributes: otherAttributes)
        let part3 = NSMutableAttributedString(string: "      ", attributes: otherAttributes)
        let part4 = NSMutableAttributedString(string: "(", attributes: otherAttributes)
        let part5 = NSMutableAttributedString(string: "1 ", attributes: amountAttributes)
        let part6 = NSMutableAttributedString(string: sign ?? ""+" = ", attributes: otherAttributes)
        let part7 = NSMutableAttributedString(string: String(format:"%0.1f",inUSD!), attributes: amountAttributes)
        let part8 = NSMutableAttributedString(string: ")", attributes: otherAttributes)
        
        let parts = [part1,part2,part3,part4,part5,part6,part7,part2,part8]
        
        let combination = NSMutableAttributedString()
        
        for part in parts {
            combination.append(part)
        }
        return combination
    }
    
}
