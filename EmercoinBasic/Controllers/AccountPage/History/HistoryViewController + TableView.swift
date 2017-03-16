
//
//  HistoryViewController + TableView.swift
//  EmercoinOne
//

import UIKit

extension HistoryViewController:UITableViewDelegate, UITableViewDataSource {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = history.transactions.count
        return count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "HistoryCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BaseTableViewCell
        
        let viewModel = HistoryTransactionViewModel.init(historyTransaction: itemAt(indexPath: indexPath))
        cell.object = viewModel
        return cell
    }
    
    private func itemAt(indexPath:IndexPath) -> HistoryTransaction {
        return history.transactions[indexPath.row]
    }
}
