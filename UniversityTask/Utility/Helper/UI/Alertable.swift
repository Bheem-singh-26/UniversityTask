//
//  Alertable.swift
//  UniversityTask
//
//  Created by Bheem Singh on 07/08/24.
//

import Foundation
import UIKit

protocol Alertable {
    func issueAlert()
}

extension Alertable where Self: UIViewController {
    func issueAlert() {
        // alert code here
    }
}

extension Alertable where Self: UIViewController {
    
    func issueAlert(title:String = "", message: String) {
        // alert code here
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: Constants.StringConstant.ok, style: .default, handler: nil)
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
    }
}
