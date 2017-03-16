//
//  Exchange.swift
//  EmercoinOne
//

import UIKit

class Exchange: NSObject {
    
    private var coursesList:[CoinCourse] = []
    
    var cointType:CoinType?
    
    var courses:[CoinCourse] {
        get {
            return coursesList
        }
    }
    
    func add(course:CoinCourse) {
        coursesList.append(course)
    }
    
    func remove(course:CoinCourse) {
        coursesList.remove(object: course)
    }
    
    func removeAll() {
        coursesList.removeAll()
    }
    
    func stubCourses() {
        
        let course1 = CoinCourse(sell: 0.0046, buy: 0.0001, type: .bitcoin, working:true)
        let course2 = CoinCourse(sell: 0.0030, buy: 0.0005, type: .livecoin, working:false)
        let course3 = CoinCourse(sell: 0.0050, buy: 0.0010, type: .xbtce, working:true)
        
        add(course: course1)
        add(course: course2)
        add(course: course3)
    }

}
