//
//  AlertViewController.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/18/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import UIKit

class AlertViewController {
    public static func showAlert(header: String, body: String, action: String) -> UIViewController {
        let alert = UIAlertController(title: header, message: body, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: action, style: UIAlertAction.Style.default, handler: nil))
        
        return alert
    }
}
