//
//  BCNotes.swift
//  EmercoinOne
//

import UIKit
import RxSwift
import RxCocoa

class BCNotes: NSObject {
    
    private var notesList:[BCNote] = [] {
        didSet {
            isChanged.onNext(true)
        }
    }
    
    var notes:Observable<[BCNote]>?

    let disposeBag = DisposeBag()
    
    var isChanged = PublishSubject<Bool>()
    
    override init() {
        super.init()
        
        notes = isChanged.asObserver()
            .map({ state in
                return self.notesList
            })
    }
    
    func add(note:BCNote) {
        notesList.append(note)
    }
    
    func remove(note:BCNote) {
        notesList.remove(object: note)
    }
    
    func removeAll() {
        notesList.removeAll()
    }
    
    func stubNotes() {
        
        let note1 = BCNote(name: "dns: forklog.lib", value: String.randomStringWithLength(10), address: String.randomStringWithLength(15), timeValue: 1824, timeType: .days)
        let note2 = BCNote(name: "ssh: mikhail", value: String.randomStringWithLength(10), address: String.randomStringWithLength(15), timeValue: 9775, timeType: .days)
        let note3 = BCNote(name: "dpo: sony", value: String.randomStringWithLength(10), address: String.randomStringWithLength(15), timeValue: 1418, timeType: .days)
        
        add(note: note1)
        add(note: note2)
        add(note: note3)
    }


}
