//
//  UIViewController+Alert.swift
//  ImageGallery
//
//  Created by Shubham Choudhary on 24/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import UIKit


extension UIViewController {
    
    // Display simple alert with title and message and return completion closure
    func showAlert(title: String = ERROR, message: String, completionHandler: ((UIAlertAction) -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: RETRY, style: .default, handler: { alertAction in
            if let handler = completionHandler {
                handler(alertAction)
            }
        }))
        alertController.addAction(UIAlertAction(title: CANCEL, style: .cancel, handler: { alertAction in
            if let handler = completionHandler {
                handler(alertAction)
            }
        }))
        present(alertController, animated: true, completion: nil)
    }
}
