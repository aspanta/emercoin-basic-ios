//
//  String + Utils.swift
//  EmercoinBasic
//

import Foundation

extension String {
    
    var first: String {
        return String(characters.prefix(1))
    }
    
    var second: String {
        return String(characters.prefix(2))
    }
    
    var last: String {
        return String(characters.suffix(1))
    }
    
    var uppercaseFirst: String {
        return first.uppercased() + String(characters.dropFirst())
    }
    
    var length: Int {
        return characters.count
    }
    
    func insert(_ string:String,index:Int) -> String {
        return  String(self.characters.prefix(index)) + string + String(self.characters.suffix(self.characters.count-index))
    }
    
    func removeLast() -> String {
        return String(characters.dropLast())
    }
    
    func stringTo(_ index:Int) -> String {
        return  String(self.characters.prefix(index))
    }
    
    static func randomStringWithLength (_ len : Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0 ..< len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        return randomString as String
    }
    
    static func coinFormat(at number:Double) -> String {
        let string = number.truncatingRemainder(dividingBy: 1.0) == 0 ? String(format: "%.0f", number) : String(number)
        return string
    }
    
    func validAmount() -> Bool {
        let pat = "\\d{1,8}\\.(\\d{1,6})?"
        let regex = try! NSRegularExpression(pattern:pat, options: [.caseInsensitive])
        let nsString = self as NSString
        let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
        let strings = results.map{nsString.substring(with: $0.range)}
        return strings.first != nil && strings.first == self
    }
}
