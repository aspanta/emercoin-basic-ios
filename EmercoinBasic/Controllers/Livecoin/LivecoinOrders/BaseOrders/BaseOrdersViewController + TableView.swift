//
//  BaseOrdersViewController + TableView.swift
//  EmercoinOne
//

import UIKit

extension BaseOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = orderSections[section].orders.count
        return count
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return orderSections.count
    }
    
    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let size = UIScreen.main.bounds.size
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: sectionHeight))
        view.backgroundColor = UIColor(hexString: "f2f2f2")
        
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: size.width, height: sectionHeight))
        label.text = orderSections[section].date
        label.font = UIFont(name: "Roboto-Medium", size: 18)!
        label.textColor = .black 
        label.textAlignment = .center
        label.center = view.center
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeight
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "BaseOrderCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BaseOrderCell
        cell.object = LCOrderViewModel(order: item(at: indexPath), showStatus: (ordersMode == .my))
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return ordersMode == .my
    }
    
    internal func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteImage = UIImageView(image: UIImage(named: "delete_icon"))
        deleteImage.contentMode = .scaleAspectFit
        
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "     ") { (action, indexPath) in
            self.removeItem(at: indexPath)
        }
        deleteAction.backgroundColor = UIColor(patternImage:deleteImage.image!)

        return [deleteAction]
    }
    
    private func removeCell(at indexPath:IndexPath) {
    
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .top)
        tableView.endUpdates()
    }
    
    private func removeSection(at indexPath:IndexPath) {
        
       // let indexSet = IndexSet.init(integer: indexPath.section)
        
        tableView.beginUpdates()
        tableView.deleteSections([indexPath.section], with: .top)
        tableView.endUpdates()
    }
    
    private func removeItem(at indexPath:IndexPath) {
        
        let order = item(at: indexPath)
        
        orderSections[indexPath.section].remove(order: order)
        removeCell(at: indexPath)
        
        if orderSections[indexPath.section].orders.count == 0 {
            orderSections.remove(at: indexPath.section)
            removeSection(at: indexPath)

        }
    }
}
