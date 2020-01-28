//
//  HomeViewController.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/25/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUIStyles()
    }
    
    @objc private func onSignOut() {
        let authManager: AuthManager = AuthManager()
        
        var alert: UIViewController!
        
        authManager.signOut() {[weak self] (success, error) in
            guard let `self` = self else { return }
            
            if error != nil {
                alert = NotificationManager.showAlert(header: "Sign out Failed", body: error!, action: "Okay")
                
                self.present(alert, animated: true, completion: nil)
            } else {
                alert = NotificationManager.showAlert(header: "Sign out Success", body: "Sign out Successful, Please re-login.", action: "Okay", handler: {(_: UIAlertAction!) in
                    self.transitionToSignIn()
                })
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func configureUIStyles() {
        let btnSignOut = UIBarButtonItem(title: "Sign out" , style: .plain, target: self, action: #selector(onSignOut))
        self.navigationItem.rightBarButtonItem = btnSignOut
    }
    
    private func transitionToSignIn() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "homeToMain", sender: self)
        }
    }
}
