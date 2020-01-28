//
//  SignInViewController.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/14/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import UIKit
import LocalAuthentication
import FirebaseAuth

class SignInViewController: UIViewController {
    @IBOutlet weak var subscriptionButton: HBOButton!
    @IBOutlet weak var txtEmailAddress: HBOTextField!
    @IBOutlet weak var txtPassword: HBOTextField!
    
    var alert: UIViewController!
    
    let localAuthContext = LAContext()
    
    override func viewDidAppear(_ animated: Bool) {
        self.canPerformBioMetricsVerification()
    }
    
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
    
    @IBAction func onSignIn(_ sender: HBOButton) {
        var fields: Dictionary<String,HBOTextField> = [:]
        var fieldErrors = [String: String]()
        
        let fieldValidator: FieldValidator = FieldValidator()
        let authManager: AuthManager = AuthManager()
        
        fields = [
            "Email": txtEmailAddress,
            "Password": txtPassword
        ]
        
        for (type, field) in fields {
            let (valid, message) = fieldValidator.validate(type: type, textField: field)
            if (!valid) {
                fieldErrors.updateValue(message, forKey: type)
            }
        }
        
        if fieldErrors.count > 0 {
            self.alert = NotificationManager.showAlert(header: "Sign In Failed", body: "The following \(fieldErrors.values.joined(separator: ", ")) field(s) are invalid.", action: "Okay")
            
            self.present(self.alert, animated: true, completion: nil)
            
            return
        }
        
        authManager.signIn(emailField: txtEmailAddress, passwordField: txtPassword) {[weak self] (success, error) in
            guard let `self` = self else { return }
            
            if (error != nil) {
                self.alert = NotificationManager.showAlert(header: "Sign In Failed", body: error!, action: "Okay")
                self.present(self.alert, animated: true, completion: nil)
            } else {
                self.transition(identifier: "signInToHome")
            }
        }
    }
    
    private func canPerformBioMetricsVerification() {
        let authManager: AuthManager = AuthManager()
        
        authManager.currentUser() {[weak self] (success, error) in
            if error != nil {
                return
            } else {
                authManager.authWithBioMetrics() {[weak self] (success, error) in
                    guard let `self` = self else { return }
                    
                    if (error != nil) {
                        self.transition(identifier: "signInToMain")
                        self.alert = NotificationManager.showAlert(header: "Authentication Failed", body: error!, action: "Okay")
                        
                        self.present(self.alert, animated: true, completion: nil)
                    } else {
                        self.transition(identifier: "signInToHome")
                    }
                }
            }
        }
    }
    
    private func transition(identifier: String) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: identifier, sender: self)
        }
    }
}
