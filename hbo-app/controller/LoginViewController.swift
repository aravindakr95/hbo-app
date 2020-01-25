//
//  ViewControllerLogin.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/14/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewControllerLogin: UIViewController {
    @IBOutlet weak var subscriptionButton: UIButton!
    @IBOutlet weak var txtEmailAddress: HBOTextField!
    @IBOutlet weak var txtPassword: HBOTextField!
    
    let validator = FieldValidator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUIStyles()
    }
    
    private func configureUIStyles() {
        subscriptionButton.layer.cornerRadius = 5
        subscriptionButton.layer.borderWidth = 2
        subscriptionButton.layer.borderColor = UIColor.gray.cgColor
        
        txtEmailAddress.layer.cornerRadius = 10
          txtEmailAddress.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        txtEmailAddress.setLeftPaddingPoints(10)
        txtEmailAddress.setRightPaddingPoints(10)
        
        txtPassword.layer.cornerRadius = 10
        txtPassword.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        txtPassword.setLeftPaddingPoints(10)
        txtPassword.setRightPaddingPoints(10)
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        var fields: Dictionary<String,HBOTextField> = [:]
        var fieldErrors = [String: String]()
        
        fields = [
            "Email": txtEmailAddress,
            "Password": txtPassword
        ]
        
        for (type, field) in fields {
                let (valid, message) = validator.validate(type: type, textField: field)
                if (!valid) {
                    fieldErrors.updateValue(message, forKey: type)
                }
        }
        
        if fieldErrors.count > 0 {
            var alert: UIViewController
            
            alert = ViewControllerAlert.showAlert(header: "Sign In Failed", body: "The following \(fieldErrors.values.joined(separator: ", ")) field(s) are invalid.", action: "Okay")
            
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        Auth.auth().signIn(withEmail: txtEmailAddress.text!, password: txtPassword.text!) { [weak self] authResult, error in
            
            if error != nil {
                let alert = ViewControllerAlert.showAlert(header: "Sign In Failed", body: (error?.localizedDescription)!, action: "Okay")
                
                self?.present(alert, animated: true, completion: nil)
                
                return
            } else {
                print("redirect")
                //TODO: Redirect to Main Page
            }
        }
    }
    
}
