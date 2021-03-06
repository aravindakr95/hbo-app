//
//  PasswordResetController.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/26/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import UIKit
import FirebaseAuth

class PasswordResetController: UIViewController {
    @IBOutlet weak var txtEmailAddress: HBOTextField!
    @IBOutlet weak var btnResetPW: HBOButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUIStyles()
        self.delegateTextFields()
        self.hideKeyboardWhenTappedAround()
    }
    
    private func delegateTextFields() {
        self.txtEmailAddress.delegate = self
    }
    
    private func configureUIStyles() {
        txtEmailAddress.layer.cornerRadius = CGFloat(10)
        txtEmailAddress.setLeftPaddingPoints(10)
        txtEmailAddress.setRightPaddingPoints(10)
    }
    
    @IBAction func onResetPassword(_ sender: HBOButton) {
        let authManager: AuthManager = AuthManager()
        
        self.btnResetPW.showLoading()
        
        authManager.sendPasswordReset(emailField: txtEmailAddress) {[weak self] (success, error) in
            guard let `self` = self else { return }
            
            var alert: UIViewController
            
            if (error != nil) {
                alert = NotificationManager.showAlert(header: "Password Reset Failed", body: error!, action: "Okay")
                
                self.present(alert, animated: true, completion: nil)
            } else {
                alert = NotificationManager.showAlert(header: "Email Sent", body: "We have sent a password reset instructions to your \(self.txtEmailAddress.text!) email address.", action: "Okay", handler: {(_: UIAlertAction!) in
                    
                    self.transitionToMain()
                })
                
                self.present(alert, animated: true, completion: nil)
            }
            self.btnResetPW.hideLoading()
        }
    }
    
    private func transitionToMain() {
        DispatchQueue.main.async {
            TransitionManager.popToRootViewController(context: self.navigationController!)
        }
    }
}
