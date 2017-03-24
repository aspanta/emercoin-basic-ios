//
//  AlertsHelper.swift
//  EmercoinBasic
//

import UIKit

class AlertsHelper {
    
    class func errorAlert(at error:NSError) -> UIAlertController {
        
        let alert = UIAlertController(
            title: "Error",
            message: String (format:error.domain),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        return alert
    }
}
