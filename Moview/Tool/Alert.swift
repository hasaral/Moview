//
//  Alert.swift
//  Moview
//
//  Created by Hasan Saral on 5.11.2023.
//

import UIKit

class AlertView: NSObject {
    class func showAlert(title: String , message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
        DispatchQueue.main.async {
            UIApplication.shared.typeKeyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
           }
    }
}
