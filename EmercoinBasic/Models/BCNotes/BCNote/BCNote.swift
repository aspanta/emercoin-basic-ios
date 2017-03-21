//
//  BCNote.swift
//  EmercoinBasic
//

import UIKit

enum TimeType {
    case days
    case months
    case years

    var value:String {
        get {
            var text = ""
            switch self {
            case .days:
                text = "Days"
            case .months:
                text = "Months"
            case .years:
                text = "Years"
            }
            return text
        }
    }
}

class BCNote: NSObject {
    
    var name:String
    var value:String
    var address:String
    var timeValue:Int
    var timeType:TimeType
    
    init(name:String, value:String, address:String, timeValue:Int, timeType:TimeType) {
        
        self.name = name
        self.value = value
        self.address = address
        self.timeValue = timeValue
        self.timeType = timeType
    }
}
