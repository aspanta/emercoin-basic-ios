//
//  LicensiesViewController + TableView.swift
//  EmercoinBasic
//

import UIKit

extension LicensiesViewController {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = licensies.licensies.count + 1
        return count
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let row = indexPath.row
        
        let identifier = row == 0 ? "LicenseLogoCell" : "LicenseCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! BaseTableViewCell
        
        if row > 0 {
            cell.object = LicenseViewModel(license: item(at: row - 1))
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row > 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row > 0 {
            let cell = tableView.cellForRow(at: indexPath) as! BaseTableViewCell
            
            let controller = LegalViewController.controller() as! LegalViewController
            controller.viewModel = cell.object as? LicenseViewModel
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    private func item(at index:Int) -> License {
        
        return licensies.licensies[index]
    }
    
}
