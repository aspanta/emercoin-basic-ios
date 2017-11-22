//
//  MyAdressViewController + TableView.swift
//  EmercoinBasic
//

import UIKit
import SwipeCellKit

extension MyAdressViewController: SwipeTableViewCellDelegate {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = addressBook.contacts.count
        return count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MyAddressCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BaseSwipeTableViewCell
        
        let viewModel = ContactViewModel(contact:itemAt(indexPath: indexPath))
        cell.delegate = self
        cell.object = viewModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let contact = itemAt(indexPath: indexPath)
        UIPasteboard.general.string = contact.address
        
        showCopyView()
    }
    
    internal func itemAt(indexPath:IndexPath) -> Contact {
        return addressBook.contacts[indexPath.row]
    }
    
    internal func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let editAction = SwipeAction(style: .default, title: " ") { action, indexPath in
            self.addEditContactViewWith(indexPath: indexPath)
        }
        
        editAction.image = UIImage(named: "edit_icon")
        editAction.backgroundColor = UIColor(hexString: "D9743C")
        
        return [editAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .none
        options.transitionStyle = .border
        options.buttonSpacing = -20
        return options
    }
    
    private func addEditContactViewWith(indexPath:IndexPath) {
        
        let editContactView = loadViewFromXib(name: "AddressBook", index: 2,
                                              frame: self.parent!.view.frame) as! AddAddressView
        let contact = itemAt(indexPath: indexPath)
        editContactView.viewModel = ContactViewModel(contact: contact)
        
        editContactView.add = ({(name) in
            self.addressBook.update(at: name, index:indexPath.row)
            self.reloadRows(at: [indexPath])
        })
        
        self.parent?.view.addSubview(editContactView)
    }
    
    private func reloadRows(at indexPaths:[IndexPath]) {
        
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: indexPaths, with: .none)
        self.tableView.endUpdates()
    }
}
