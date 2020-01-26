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
import KeychainSwift

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
    
    let validator = FieldValidator()
    
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
        
        fields = [
            "First Name": txtFirstName,
            "Last Name": txtLastName,
            "Email": txtEmailAddress,
            "Password": txtPassword,
            "Zip Code": txtZipCode
        ]
        
        for (type, field) in fields {
            if type == "Password" {
                let (valid, message) = validator.validate(type: type, textField: field, optionalField: txtConfirmPassword)
                if (!valid ) {
                    fieldErrors.updateValue(message, forKey: type)
                }
            } else {
                let (valid, message) = validator.validate(type: type, textField: field)
                if (!valid) {
                    fieldErrors.updateValue(message, forKey: type)
                }
            }
        }
        
        if fieldErrors.count > 0 {
            var alert: UIViewController
            
            alert = AlertViewController.showAlert(header: "Registration Failed", body: "The following \(fieldErrors.values.joined(separator: ", ")) field(s) are invalid.", action: "Okay")
            
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        // FIXME: cbAgreement isChecked method returns wrong state of the checkbox
        if isChecked {
            print("CB \(cbAgreement.isChecked)")
            var alert: UIViewController
            
            alert = AlertViewController.showAlert(header: "Registration Failed", body: "Please read our Privacy Policy and agree to the Terms and Conditions.", action: "Okay")
            
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        Auth.auth().createUser(withEmail: txtEmailAddress.text!, password: txtPassword.text!) {
            authResult, error in
            if (error != nil) {
                var alert: UIViewController
                alert = AlertViewController.showAlert(header: "Registration Failed", body: (error?.localizedDescription)!, action: "Okay")
                
                self.present(alert, animated: true, completion: nil)
            } else {
                let database = Firestore.firestore()
                
                database.collection("users").addDocument(data: [
                    "uid": authResult!.user.uid,
                    "firstName": self.txtFirstName.text!,
                    "lastName": self.txtLastName.text!,
                    "zipCode": self.txtZipCode.text!
                ]) { (error) in
                    var alert: UIViewController
                    
                    if error != nil {
                        alert = AlertViewController.showAlert(header: "Registration Failed", body: (error?.localizedDescription)!, action: "Okay")
                        
                        self.present(alert, animated: true, completion: nil)
                        
                        return
                    } else {
                        guard let email = self.txtEmailAddress.text,
                            let password = self.txtPassword.text else { return }
                        
                        let keychain = KeychainSwift()
                        
                        keychain.set(email, forKey: "email")
                        keychain.set(password, forKey: "password")
                        
                        alert = AlertViewController.showAlert(header: "Registration Success", body: "Registration is Successful, Please Sign In.", action: "Okay", handler: {(_: UIAlertAction!) in
                            self.transitionToMain()
                        })
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    private func transitionToMain() {
        let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "main") as! MainViewController
        view.window?.rootViewController = mainViewController
        
        view.window?.makeKeyAndVisible()
    }
}

