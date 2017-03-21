//
//  MyNotesViewController.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

enum TableCellAction {
    case remove
    case edit
    case add
}

class MyNotesViewController: UIViewController, IndicatorInfoProvider, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet internal weak var tableView:UITableView!
    @IBOutlet internal weak var noNotesView:UIView!
    
    let disposeBag = DisposeBag()
    var viewModel = BCNotesViewModel()
    
    var filterString:String = ""
    
    var notes:[BCNote] = [] {
        didSet {
            if tableCellAction == .add {
                tableView.reload()
            }
        }
    }
    
    var tableCellAction:TableCellAction = .add

    override class func storyboardName() -> String {
        return "Blockchain"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.stubNotes()
    }
    
    private func setupUI() {
       
        viewModel.notes.subscribe(onNext:{ [weak self] notes in
            self?.notes = notes
        })
            .addDisposableTo(disposeBag)
        
        viewModel.isExistNotes.bindTo(noNotesView.rx.isHidden)
            .addDisposableTo(disposeBag)

        tableView.baseSetup()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "My Records")
    }
    
    func addNote(note:BCNote) {
        tableCellAction = .add
        viewModel.add(note: note)
    }
    
    @IBAction func nvsInfoButtonPressed() {
        let vc = NVSInfoViewController.controller()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
