//
//  UIViewController+Extension.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import Foundation
import UIKit

// MARK: - EXTENSIONS

extension UIViewController {
    func displayAlert(title: String? = nil, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func errorMessage(element: ErrorType) {
        displayAlert(message: element.message)
    }
}
