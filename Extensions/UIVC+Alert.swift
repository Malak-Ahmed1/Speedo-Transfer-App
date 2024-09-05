//
//  UIVC+Alert.swift
//  Speedo Transfer App
//
//  Created by 1234 on 04/09/2024.
//

import Foundation
import UIKit


extension UIViewController {
    

    func showAlert(title: String, message: String, okHandler: (() -> Void)?, cancelHandler: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // OK action with a custom handler
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            okHandler?()
            
        }
        alertController.addAction(okAction)
        
        // Only add the Cancel action if cancelHandler is not nil
        if let cancelHandler = cancelHandler {
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                cancelHandler() // Call the Cancel handler
            }
            alertController.addAction(cancelAction)
        }
     
        
        self.present(alertController, animated: true, completion: nil)
        
    }

}
