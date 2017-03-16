//
//  ExchangeViewController + TableView.swift
//  EmercoinOne
//

import UIKit

extension ExchangeViewController {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = exchange.courses.count
        return count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ExchangeCoinCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BaseTableViewCell
        
        let viewModel = ExchangeCoinViewModel(coinCourse: itemAt(indexPath: indexPath))
        cell.object = viewModel
        return cell
    }
    
    private func itemAt(indexPath:IndexPath) -> CoinCourse {
        return exchange.courses[indexPath.row]
    }
}
