//
//  LivecoinTradeViewController + TableView.swift
//  EmercoinOne
//

import UIKit

let rowsCount = 4

let menuItems = ["My balances", "Place order", "My orders", "My trade history"]

extension LivecoinTradeViewController {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "LCTradeMenuCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BaseTableViewCell
        cell.object = menuItems[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            showBalancesController()
        case 1:
            showOrdersController(at: .putOrder)
        case 2:
            showOrdersController(at: .my)
        case 3:
            showOrdersController(at: .history)
        default:
            break;
        }
    }
    

}
