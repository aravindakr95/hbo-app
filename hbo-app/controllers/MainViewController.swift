//
//  MainViewController.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/18/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        AuthManager().currentUser() {(userData, error) in
            if userData != nil {
                self.transition(identifier: "mainToSignIn")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUIStyles()
    }
    
    @IBAction func onSignIn(_ sender: HBOButton) {
        self.transition(identifier: "mainToSignIn")
    }
    
    @IBAction func onRegister(_ sender: HBOButton) {
        self.transition(identifier: "mainToRegister")
    }
    
    private func configureUIStyles() {
        navigationController?.navigationBar.barStyle = UIBarStyle.black
    }
    
    private func transition(identifier: String) {
        TransitionManager.transition(sender: self, identifier: identifier)
    }
}
