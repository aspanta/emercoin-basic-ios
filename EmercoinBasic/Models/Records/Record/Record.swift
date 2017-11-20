//
//  BCNote.swift
//  EmercoinBasic
//

import UIKit
import ObjectMapper
import RealmSwift

let blocksInDay = 175

class Record: Object, Mappable {
    
    @objc dynamic var name = ""
    @objc dynamic var value = ""
    @objc dynamic var address = ""
    @objc dynamic var isExpired = false
    @objc dynamic var isTransferred = false
    @objc dynamic var isDeleted = false
    @objc dynamic var isMyRecord = true
    
    @objc dynamic var expiresIn = 0 {
        didSet{
            expiresInDays = Int((Double(expiresIn)/Double(blocksInDay)).rounded())
        }
    }
    @objc dynamic var expiresInDays = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        address <- map["address"]
        value <- map["value"]
        expiresIn <- map["expires_in"]
        isExpired <- map["expired"]
        isDeleted <- map["deleted"]
        isTransferred <- map["transferred"]
    }
}
