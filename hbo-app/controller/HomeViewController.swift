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
    @IBOutlet weak var lblCurrentUser: UILabel!
    
    var currentUser: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnSignOut = UIBarButtonItem(title: "Sign Out" , style: .plain, target: self, action: #selector(onSignOut))
        
        self.navigationItem.rightBarButtonItem = btnSignOut
        
        lblCurrentUser.text = "Welcome \(currentUser)"
    }
    
    @objc func onSignOut() {
        do {
            try Auth.auth().signOut()
            
            let alert = AlertViewController.showAlert(header: "Sign Out Success", body: "Sign out Successful, Please re-login.", action: "Okay")
            
            self.present(alert, animated: true, completion: nil)
            
            self.transitionToSignIn()
        } catch {
            let alert = AlertViewController.showAlert(header: "Sign Out Failed", body: error as! String, action: "Okay")
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func transitionToSignIn() {
        let signInViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signIn") as! SignInViewController
        view.window?.rootViewController = signInViewController
        
        view.window?.makeKeyAndVisible()
    }
}
