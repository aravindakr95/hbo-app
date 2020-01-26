//
//  ForgotPasswordViewController.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/26/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import UIKit

import FirebaseAuth

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var txtEmailAddress: HBOTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUIStyles()
    }
    
    private func configureUIStyles() {
        txtEmailAddress.layer.cornerRadius = CGFloat(10)
        txtEmailAddress.setLeftPaddingPoints(10)
        txtEmailAddress.setRightPaddingPoints(10)
    }
    
    @IBAction func onResetPassword(_ sender: HBOButton) {
        Auth.auth().sendPasswordReset(withEmail: txtEmailAddress.text!) { (error) in
            if (error != nil) {
                var alert: UIViewController
                
                alert = AlertViewController.showAlert(header: "Password Reset Failed", body: (error?.localizedDescription)!, action: "Okay")
                
                self.present(alert, animated: true, completion: nil)
            } else {
                var alert: UIViewController
                
                alert = AlertViewController.showAlert(header: "Email Sent", body: "We have sent a password reset instructions to your \(self.txtEmailAddress.text!) email address.", action: "Okay")
                
                alert = AlertViewController.showAlert(header: "Email Sent", body: "We have sent a password reset instructions to your \(self.txtEmailAddress.text!) email address.", action: "Okay", handler: {(_: UIAlertAction!) in
                    self.transitionToSignIn()
                })
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func transitionToSignIn() {
        let signInViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signIn") as! SignInViewController
        view.window?.rootViewController = signInViewController
        
        view.window?.makeKeyAndVisible()
    }
}
