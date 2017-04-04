//
//  BCNote.swift
//  EmercoinBasic
//

import UIKit
import ObjectMapper
import RealmSwift

let blocksInDay = 182

class Record: Object, Mappable {
    
    dynamic var name = ""
    dynamic var value = ""
    dynamic var address = ""
    
    dynamic var expiresIn = 0 {
        didSet{
            expiresInDays = expiresIn / blocksInDay
        }
    }
    dynamic var expiresInDays = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        address <- map["address"]
        value <- map["value"]
        expiresIn <- map["expires_in"]
    }
}