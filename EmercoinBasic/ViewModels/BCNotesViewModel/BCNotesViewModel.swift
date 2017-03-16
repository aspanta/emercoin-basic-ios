//
//  BCNotesViewModel.swift
//  EmercoinOne
//

import UIKit
import RxSwift
import RxCocoa

class BCNotesViewModel {
    
    let disposeBag = DisposeBag()
    
    let notes = PublishSubject<[BCNote]>()
    let isExistNotes = PublishSubject<Bool>()
    
    private var model = BCNotes()
    
    var filterString:String = ""
    
    init() {
       
        model.notes?.subscribe(onNext:{ [weak self] notes in
            
            if (self?.filterString.length)! > 0 {
                let filteredNotes = notes.filter({ (record) -> Bool in
                    return record.name.contains((self?.filterString)!)
                })
                self?.notes.onNext(filteredNotes)
                self?.isExistNotes.onNext(filteredNotes.count > 0)
            } else {
                self?.notes.onNext(notes)
                self?.isExistNotes.onNext(notes.count > 0)
            }
            
        })
        .addDisposableTo(disposeBag)
    }
    
    func add(note:BCNote) {
        model.add(note: note)
    }
    
    func remove(note:BCNote) {
        model.remove(note: note)
    }
    
    func removeAll() {
        model.removeAll()
    }
    
    func stubNotes() {
        model.stubNotes()
    }
    
    func searchRecords(at text:String) {
        self.filterString = text
        model.isChanged.onNext(true)
    }
}
