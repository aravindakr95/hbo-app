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
    
    @IBOutlet weak var btnSignIn: HBOButton!
    
    var alert: UIViewController!
    
    let localAuthContext: LAContext = LAContext()
    let authManager: AuthManager = AuthManager()
    
    override func viewDidAppear(_ animated: Bool) {
        let isAuthorized = UserDefaults.standard.bool(forKey: "isAuthorized")
        
        AuthManager().currentUser {[weak self] (user, error) in
            if error == nil && isAuthorized {
                self!.canPerformBioMetricsVerification()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUIStyles()
        self.delegateFields()
        self.hideKeyboardWhenTappedAround()
    }
    
    private func configureUIStyles() {
        subscriptionButton.layer.cornerRadius = 5
        subscriptionButton.layer.borderWidth = 2
        subscriptionButton.layer.borderColor = UIColor.gray.cgColor
        
        txtEmailAddress.roundCorners([.topLeft, .topRight], radius: 10)
        txtEmailAddress.setLeftPaddingPoints(10)
        txtEmailAddress.setRightPaddingPoints(10)
        
        txtPassword.roundCorners([.bottomLeft, .bottomRight], radius: 10)
        txtPassword.setLeftPaddingPoints(10)
        txtPassword.setRightPaddingPoints(10)
    }
    
    private func delegateFields() {
        self.txtEmailAddress.delegate = self
        self.txtPassword.delegate = self
    }
    
    @IBAction func onSignIn(_ sender: HBOButton) {
        var fields: Dictionary<String, HBOTextField> = [:]
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
        
        self.btnSignIn.showLoading()
        
        authManager.signIn(emailField: txtEmailAddress, passwordField: txtPassword) {[weak self] (success, error) in
            guard let `self` = self else { return }
            
            if (error != nil) {
                self.alert = NotificationManager.showAlert(header: "Sign In Failed", body: error!, action: "Okay")
                self.present(self.alert, animated: true, completion: nil)
            } else {
                UserDefaults.standard.set(true, forKey: "isAuthorized")
                self.transition(identifier: "searchMoviesVC")
            }
            
            self.btnSignIn.hideLoading()
        }
    }
    
    @IBAction func onForgotPassword(_ sender: HBOButton) {
        self.transition(identifier: "pwResetVC")
    }
    
    private func canPerformBioMetricsVerification() {
        self.authManager.authWithBioMetrics {[weak self] (success, error) in
            guard let `self` = self else { return }
            
            if (error != nil) {
                UserDefaults.standard.set(false, forKey: "isAuthorized")
                
                DispatchQueue.main.async {
                    TransitionManager.popToRootViewController(context: self.navigationController!)
                }
                
                self.alert = NotificationManager.showAlert(header: "Authentication Failed", body: error!, action: "Okay")
                self.present(self.alert, animated: true, completion: nil)
            } else {
                
                self.transition(identifier: "searchMoviesVC")
            }
        }
    }
    
    private func transition(identifier: String) {
        DispatchQueue.main.async {
            TransitionManager.pushViewController(storyBoardName: "Main", vcIdentifier: identifier, context: self.navigationController!)
        }
    }
}
