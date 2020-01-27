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
import KeychainSwift

class SignInViewController: UIViewController {
    @IBOutlet weak var subscriptionButton: UIButton!
    @IBOutlet weak var txtEmailAddress: HBOTextField!
    @IBOutlet weak var txtPassword: HBOTextField!
    
    @IBOutlet weak var btnBiometrics: HBOButton!
    
    let validator = ValidatorController()
    let localAuthContext = LAContext()
    
    var keychainEmail: String = ""
    var keychainPassword: String = ""
    
    var currentUserEmail: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUIStyles()
    }
    
    private func configureUIStyles() {
        btnBiometrics.isHidden = true
        
        if  localAuthContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: nil) {
            
            if localAuthContext.biometryType == LABiometryType.faceID  {
                btnBiometrics.isHidden = false
                btnBiometrics.setImage(UIImage(named: "face-id"), for: .normal)
            } else {
                btnBiometrics.isHidden = false
                btnBiometrics.setImage(UIImage(named: "touch-id"), for: .normal)
            }
        }
        
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
    
    @IBAction func authWithBioMetrics(_ sender: HBOButton) {
        var error: NSError?
        
        if localAuthContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let biometricType = localAuthContext.biometryType == LABiometryType.faceID ? "Face ID" : "Touch ID"
            let reason = "Authenticate with \(biometricType)"
            
            localAuthContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply:
                {(success, error) in
                    if success {
                        let keychain = KeychainSwift()
                        
                        if keychain.get("email") != nil && keychain.get("password") != nil {
                            self.keychainEmail = keychain.get("email")!
                            self.keychainPassword = keychain.get("password")!
                            
                            self.authenticate(email: self.keychainEmail, password: self.keychainPassword)
                        }
                    }
                    else {
                        var alert: UIViewController
                        
                        alert = AlertViewController.showAlert(header: "Authentication Failed", body: (error?.localizedDescription)!, action: "Okay")
                        
                        self.present(alert, animated: true, completion: nil)
                    }
            })
        }
        else {
            var alert: UIViewController
            
            alert = AlertViewController.showAlert(header: "Authentication Failed", body: "Device is not supported for Biometrics Authentication.", action: "Okay")
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func onSignIn(_ sender: HBOButton) {
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
            
            alert = AlertViewController.showAlert(header: "Sign In Failed", body: "The following \(fieldErrors.values.joined(separator: ", ")) field(s) are invalid.", action: "Okay")
            
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        self.authenticate(email: txtEmailAddress.text!, password: txtPassword.text!)
    }
    
    private func authenticate(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if error != nil {
                let alert = AlertViewController.showAlert(header: "Sign In Failed", body: (error?.localizedDescription)!, action: "Okay")
                
                self!.present(alert, animated: true, completion: nil)
                
                return
            } else {
                self!.currentUserEmail = authResult!.user.email!
                self!.performSegue(withIdentifier: "homeSegue", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeSegue" {
            let homeViewController = segue.destination as? HomeViewController
            homeViewController!.currentUser = currentUserEmail
        }
    }
    
    
}
