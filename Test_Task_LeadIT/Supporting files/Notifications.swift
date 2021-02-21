//
//  Notifications.swift
//  Test_Task_LeadIT
//
//  Created by Zufar Suleimanov on 21.02.2021.
//

import UIKit

public class Notifications {
    class func callAlert(title: String, message: String, in ViewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        ViewController.present(alert, animated: true, completion: nil)
    }
}
