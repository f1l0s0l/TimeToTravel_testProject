//
//  AlertNotification.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 16.05.2023.
//

import UIKit

final class AlertNotification {
    static let shared = AlertNotification()
    
    func presentDefaultWrongAlert(for viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "Ok",
            style: .default
        )
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true)
    }
    
}


