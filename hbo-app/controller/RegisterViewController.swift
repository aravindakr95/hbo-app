//
//  RegisterViewController.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/12/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {
    @IBOutlet weak var txtFirstName: HBOTextField!
    @IBOutlet weak var txtLastName: HBOTextField!
    @IBOutlet weak var txtEmailAddress: HBOTextField!
    @IBOutlet weak var txtPassword: HBOTextField!
    @IBOutlet weak var txtConfirmPassword: HBOTextField!
    @IBOutlet weak var txtZipCode: HBOTextField!
    
    @IBOutlet weak var cbAgreement: HBOCheckBox!
    
    @IBOutlet weak var btnRegister: HBOButton!
    @IBOutlet weak var btnSignIn: HBOButton!
    
    var alert: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUIStyles()
    }
    
    private func configureUIStyles() {
        txtFirstName.layer.cornerRadius = 10
        txtFirstName.layer.maskedCorners = .layerMinXMinYCorner
        txtFirstName.setLeftPaddingPoints(10)
        txtFirstName.setRightPaddingPoints(10)
        
        txtLastName.layer.cornerRadius = 10
        txtLastName.layer.maskedCorners = .layerMaxXMinYCorner
        txtLastName.setLeftPaddingPoints(10)
        txtLastName.setRightPaddingPoints(10)
        
        txtEmailAddress.layer.cornerRadius = 10
        txtEmailAddress.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        txtEmailAddress.setLeftPaddingPoints(10)
        txtEmailAddress.setRightPaddingPoints(10)
        
        txtPassword.layer.cornerRadius = 10
        txtPassword.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        txtPassword.setLeftPaddingPoints(10)
        txtPassword.setRightPaddingPoints(10)
        
        txtConfirmPassword.layer.cornerRadius = 10
        txtConfirmPassword.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        txtConfirmPassword.setLeftPaddingPoints(10)
        txtConfirmPassword.setRightPaddingPoints(10)
        
        txtZipCode.layer.cornerRadius = CGFloat(10)
        txtZipCode.setLeftPaddingPoints(10)
        txtZipCode.setRightPaddingPoints(10)
        
    }
    
    @IBAction func onRegister(_ sender: HBOButton!) {
        var fields: Dictionary<String,HBOTextField> = [:]
        var fieldErrors = [String: String]()
        
        // TODO: Refer usage comment
        let isChecked = !cbAgreement.isChecked
        let authManager: AuthManager = AuthManager()
        let fieldValidator = FieldValidator()
        
        fields = [
            "First Name": txtFirstName,
            "Last Name": txtLastName,
            "Email": txtEmailAddress,
            "Password": txtPassword,
            "Zip Code": txtZipCode
        ]
        
        for (type, field) in fields {
            if type == "Password" {
                let (valid, message) = fieldValidator.validate(type: type, textField: field, optionalField: txtConfirmPassword)
                if (!valid ) {
                    fieldErrors.updateValue(message, forKey: type)
                }
            } else {
                let (valid, message) = fieldValidator.validate(type: type, textField: field)
                if (!valid) {
                    fieldErrors.updateValue(message, forKey: type)
                }
            }
        }
        
        if fieldErrors.count > 0 {
            alert = NotificationManager.showAlert(header: "Registration Failed", body: "The following \(fieldErrors.values.joined(separator: ", ")) field(s) are missing or invalid.", action: "Okay")
            
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        // FIXME: cbAgreement isChecked method returns wrong state of the checkbox
        if isChecked {
            alert = NotificationManager.showAlert(header: "Registration Failed", body: "Please read our Privacy Policy and agree to the Terms and Conditions.", action: "Okay")
            
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        authManager.createUser(emailField: txtEmailAddress, passwordField: txtPassword) {[weak self] (userData, error) in
            guard let `self` = self else { return }
            
            if (error != nil) {
                self.alert = NotificationManager.showAlert(header: "Registration Failed", body: error!, action: "Okay")
                
                self.present(self.alert, animated: true, completion: nil)
            } else {
                let databaseManager: DatabaseManager = DatabaseManager()
                
                let data: Dictionary<String, String> = [
                    "uid": userData!.uid,
                    "firstName": self.txtFirstName.text!,
                    "lastName": self.txtLastName.text!,
                    "zipCode": self.txtZipCode.text!
                ]
                
                databaseManager.insert(collection: "users", data: data) {[weak self] (success, error) in
                    guard let `self` = self else { return }
                    
                    if (error != nil) {
                        self.alert = NotificationManager.showAlert(header: "Registration Failed", body: error!, action: "Okay")
                            self.present(self.alert, animated: true, completion: nil)
                            
                        return
                    } else {
                        self.alert = NotificationManager.showAlert(header: "Registration Success", body: "Registration is Successful, Please Sign In.", action: "Okay", handler: {(_: UIAlertAction!) in
                            self.transitionToMain()
                        })
                        self.present(self.alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    private func transitionToMain() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "registerToMain", sender: self)
        }
    }
}

