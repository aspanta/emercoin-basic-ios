//
//  MyNotesViewController + TableView.swift
//  EmercoinBasic
//

import UIKit

extension MyNotesViewController {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = notes.count
        return count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "RecordCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RecordCell
        
        let viewModel = BCNoteViewModel(note: itemAt(indexPath: indexPath))
        cell.object = viewModel
        cell.indexPath = indexPath
        cell.timePressed = {[weak self](indexPath)in
            if !cell.isEditing {
                self?.addNoteShortInfoViewWith(indexPath: indexPath)
            }
        }
        
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        addNoteInfoViewWith(indexPath: indexPath)
    }
    
    internal func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    internal func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteImage = UIImageView(image: UIImage(named: "delete_icon"))
        let editImage = UIImageView(image: UIImage(named: "edit_icon"))
        deleteImage.contentMode = .scaleAspectFit
        editImage.contentMode = .scaleAspectFit
        
        let editAction = UITableViewRowAction(style: .normal, title: "     ") { (action, indexPath) in
            let record = self.itemAt(indexPath: indexPath)
            self.showEditRecordController(at: record)
        }
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "     ") { (action, indexPath) in
            self.addDeleteNoteViewWith(indexPath: indexPath)
        }
        deleteAction.backgroundColor = UIColor(patternImage:deleteImage.image!)
        editAction.backgroundColor = UIColor(patternImage:editImage.image!)
        return [deleteAction, editAction]
    }
    
    private func addDeleteNoteViewWith(indexPath:IndexPath) {
        
        let deleteNoteView = getRecordView(at: 0) as! DeleteRecordView
        deleteNoteView.delete = ({
            self.removeCellAt(indexPath: indexPath)
        })
        
        deleteNoteView.cancel = ({
            self.reloadRows(at: [indexPath])
        })
        
        self.parent?.view.addSubview(deleteNoteView)
    }
    
    private func addNoteInfoViewWith(indexPath:IndexPath) {
        
        let noteInfoView = getRecordView(at: 1) as! RecordInfoVIew
        
        let note = itemAt(indexPath: indexPath)
        noteInfoView.viewModel = BCNoteViewModel(note: note)
        
        self.parent?.view.addSubview(noteInfoView)
    }
    
    private func addNoteShortInfoViewWith(indexPath:IndexPath) {
        
        let noteInfoView = getRecordView(at: 2) as! RecordShortInfoView
        
        let note = itemAt(indexPath: indexPath)
        noteInfoView.viewModel = BCNoteViewModel(note: note)
        
        self.parent?.view.addSubview(noteInfoView)
    }
    
    private func getRecordView(at index:Int) -> UIView {
        return loadViewFromXib(name: "MyRecords", index: index, frame: self.parent!.view.frame)
    }
    
    private func removeCellAt(indexPath:IndexPath) {
        
        tableCellAction = .remove
        
        let item = itemAt(indexPath: indexPath)
        viewModel.remove(note: item)
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .top)
        tableView.endUpdates()
        
        reloadRows()
    }
    
    private func reloadRows(at indexPaths:[IndexPath]) {
        
        tableCellAction = .edit
        
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: indexPaths, with: .none)
        self.tableView.endUpdates()
    }
    
    private func reloadRows() {
        
        tableCellAction = .edit
        
        self.tableView.beginUpdates()
        self.tableView.reloadData()
        self.tableView.endUpdates()
    }

    private func itemAt(indexPath:IndexPath) -> BCNote {
        return notes[indexPath.row]
    }
    
    private func showEditRecordController(at record:BCNote) {
        
        let controller = NamesViewController.controller() as! NamesViewController
        controller.subController = .createNVS
        
        controller.record = record
        controller.created = {record in
            self.reloadRows()
        }
        controller.isEditingMode = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
