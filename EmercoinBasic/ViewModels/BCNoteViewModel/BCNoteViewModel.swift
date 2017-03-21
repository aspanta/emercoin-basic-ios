//
//  BCNoteViewModel.swift
//  EmercoinBasic
//

import UIKit

class BCNoteViewModel {

    var name:String
    var address:String
    var value:String
    var timeValue:Int
    var timeType:TimeType
    
    init(note:BCNote) {
        
        self.name = note.name
        self.address = note.address
        self.value = note.value
        self.timeValue = note.timeValue
        self.timeType = note.timeType
        
    }
}
