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
        do {
            try Auth.auth().signOut()
            
            let alert = AlertViewController.showAlert(header: "Sign out Success", body: "Sign out Successful, Please re-login.", action: "Okay")
            
            self.present(alert, animated: true, completion: nil)
            
            self.transitionToSignIn()
        } catch {
            let alert = AlertViewController.showAlert(header: "Sign out Failed", body: error as! String, action: "Okay")
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func configureUIStyles() {
        let btnSignOut = UIBarButtonItem(title: "Sign out" , style: .plain, target: self, action: #selector(onSignOut))
        
        self.navigationItem.rightBarButtonItem = btnSignOut
    }
    
    private func transitionToSignIn() {
        TransitionController.transition(selfView: view, sbName: "Main", identifier: "signIn")
    }
}
