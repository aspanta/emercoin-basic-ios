//
//  LivecoinBalancesViewController + TableView.swift
//  EmercoinOne
//

import UIKit

extension LivecoinBalancesViewController {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = section == 0 ? balances.coins.currencies.count : balances.currencies.currencies.count
        return count
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }
    
    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "" : "Cryptocurrency"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {return nil}
        
        let size = UIScreen.main.bounds.size
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: sectionHeight))
        view.backgroundColor = UIColor(hexString: "EAEAEA")
        
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: size.width, height: sectionHeight))
        label.text = "Cryptocurrency"
        label.font = UIFont(name: "Roboto-Regular", size: 18)!
        label.textColor = UIColor(hexString: "7AAAD7")
        label.textAlignment = .center
        label.center = view.center
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.0 : sectionHeight
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height = 0.0
        
        let isSelectedRow = selectedRows.contains(indexPath)
        
        if isSelectedRow {
            height = Constants.CellHeights.LCBCell.Expanded
        } else {
            height = Constants.CellHeights.LCBCell.Collapsed
        }
            
        return CGFloat(height)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cell = cell as! LCBCell
        cell.isExpanded = selectedRows.contains(indexPath)
        cell.object = LCCurrencyViewModel(currency: item(at: indexPath))
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "LCBCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LCBCell
        
        cell.indexPath = indexPath
        cell.arrowPressed = {[weak self] indexPathPressed in
            self?.expandedCell(indexPath: indexPath)
        }
        
        return cell
    }
    
    private func expandedCell(indexPath:IndexPath) {
        
        let isCollapsed = !selectedRows.contains(indexPath)
        
        if isCollapsed {
            selectedRows.append(indexPath)
        } else {
            selectedRows.remove(object: indexPath)
        }
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .none)
        tableView.endUpdates()
    }
}
