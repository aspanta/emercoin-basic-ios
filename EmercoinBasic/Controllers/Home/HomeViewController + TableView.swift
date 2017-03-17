//
//  HomeViewController + TableView.swift
//  EmercoinOne
//

import UIKit

let cellIdentifiers = ["HomeMyMoneyCell","HomeCourseCell"]

extension HomeViewController {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height = 0.0
        
        let isSelectedRow = selectedRows.contains(indexPath)
        
        switch indexPath.row {
        case 0:height = Constants.CellHeights.HomeMyMoneyCell.Collapsed
        if isSelectedRow {
            let coinsHeight = Constants.CellHeights.HomeMyMoneyCell.MoneyView * Double(coins.count)
            height += coinsHeight
            }
        case 1:height = Constants.CellHeights.HomeCourseCell.Collapsed
        if isSelectedRow {
            let coinsHeight = Constants.CellHeights.HomeCourseCell.CourseView * 2.0
            height += coinsHeight
            }
            
        default:break
        }
        
        return CGFloat(height)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = cellIdentifiers[indexPath.row]
        
        let cell:BaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BaseTableViewCell
        
        cell.indexPath = indexPath
        
        cell.pressedCell = {[weak self] (selIndexPath) in
            self?.expandedCell(indexPath: selIndexPath)
        }
        
        if indexPath.row == 0 {
            
             let moneyCell = cell as! HomeMyMoneyCell
            moneyCell.pressed = {[weak self] (type) in
                self?.showOperationController()
            }
            
            cell.object = coins
        } else {
            cell.updateUI()
        }
        
        return cell
    }
    
    private func showOperationController() {
    
        let controller = CoinOperationsViewController.controller() as! CoinOperationsViewController
        controller.coinsOperation = .historyAndOperations
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func expandedCell(indexPath:IndexPath) {
        
        if !selectedRows.contains(indexPath) {
            selectedRows.append(indexPath)
        } else {
            selectedRows.remove(object: indexPath)
        }
        
        tableView.reload()
    }
}
