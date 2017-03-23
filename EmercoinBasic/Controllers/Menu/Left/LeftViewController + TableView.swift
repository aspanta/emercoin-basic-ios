//
//  LeftViewController + TableView.swift
//  EmercoinBasic
//

import UIKit

extension LeftViewController: UITableViewDelegate, UITableViewDataSource {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuItems.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier = "MenuDefaultCell"
        
        let row = indexPath.row
        
        switch row {
            case 3:cellIdentifier = "MenuBCToolsCell"
            case 7:cellIdentifier = "MenuPoliticsCell"
            case 8:cellIdentifier = "MenuExitCell"
            default:break
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BaseTableViewCell
        cell.object = itemAt(indexPath: indexPath)
        
        if row == 7 || row == 3 {
            let subCell = cell as! MenuDefaultCell
            subCell.pressedSubMenu = {[weak self] index in
                if self?.pressed != nil {
                    self?.pressed!(indexPath.row, index)
                }
            }
        }
        
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let index = indexPath.row
        
        if pressed != nil {
            pressed!(index,-1)
        }
    }
    
    private func itemAt(indexPath:IndexPath) -> MenuItem {
        return menuItems[indexPath.row]
    }
    
}