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
    }
    
    @IBAction func onSignout(_ sender: UIBarButtonItem) {
        let authManager: AuthManager = AuthManager()
        
        var alert: UIViewController!
        
        authManager.signOut {[weak self] (success, error) in
            guard let `self` = self else { return }
            
            if error != nil {
                alert = NotificationManager.showAlert(header: "Sign out Failed", body: error!, action: "Okay")
                
                self.present(alert, animated: true, completion: nil)
            } else {
                UserDefaults.standard.set(false, forKey: "isAuthorized")
                
                alert = NotificationManager.showAlert(header: "Sign out Success", body: "Sign out Successful, Please re-login.", action: "Okay", handler: {(_: UIAlertAction!) in
                    self.transitionToMain()
                })
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func transitionToMain() {
        DispatchQueue.main.async {
            TransitionManager.popToRootViewController(context: self.navigationController!)
        }
    }
}
