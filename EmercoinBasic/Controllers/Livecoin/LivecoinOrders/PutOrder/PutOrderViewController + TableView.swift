//
//  PutOrderViewController + TableView.swift
//  EmercoinOne
//

import UIKit

extension PutOrderViewController: UITableViewDelegate, UITableViewDataSource {

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = orders.count
        return count
    }
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "PutOrderCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BaseTableViewCell
        cell.object = LCPutOrderViewModel(order: item(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    internal func addPutOrderView() {
        
        let view = loadViewFromXib(name: "PutOrder", index: 0) as! PutOrderView
        view.frame = (parent?.view.bounds)!
        view.title = orderPutType == .buy ? "Buy" : "Sell"
        
        self.parent?.view.addSubview(view)
    }
}
