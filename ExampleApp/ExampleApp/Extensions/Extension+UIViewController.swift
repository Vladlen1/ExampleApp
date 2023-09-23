//
//  Extension+UIViewController.swift
//  ExampleApp
//
//  Created by Vlad Birukov on 2023-09-23.
//

import UIKit

extension UIViewController {
    
    func showErrorAlert(with message: String) {
        let alertController = UIAlertController(
            title: StringConstants.errorTitle,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: StringConstants.okTitle,
            style: .default,
            handler: nil
        )
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
