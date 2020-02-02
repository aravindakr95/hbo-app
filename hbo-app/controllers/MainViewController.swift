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
        AuthManager().currentUser {(userData, error) in
            let isAuthorized = UserDefaults.standard.bool(forKey: "isAuthorized")
            if userData != nil && isAuthorized {
                self.transition(identifier: "signInVC")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUIStyles()
    }
    
    @IBAction func onSignIn(_ sender: HBOButton) {
        self.transition(identifier: "signInVC")
    }
    
    @IBAction func onRegister(_ sender: HBOButton) {
        self.transition(identifier: "registerVC")
    }
    
    private func configureUIStyles() {
        navigationController?.navigationBar.barStyle = UIBarStyle.black
    }
    
    private func transition(identifier: String) {
        DispatchQueue.main.async {
            TransitionManager.pushViewController(storyBoardName: "Main", vcIdentifier: identifier, context: self.navigationController!)
        }
    }
}
