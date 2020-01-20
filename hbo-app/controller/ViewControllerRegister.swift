//
//  ViewControllerRegister.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/12/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewControllerRegister: UIViewController {
    @IBOutlet weak var txtFirstName: HBOTextField!
    @IBOutlet weak var txtLastName: HBOTextField!
    @IBOutlet weak var txtEmailAddress: HBOTextField!
    @IBOutlet weak var txtPassword: HBOTextField!
    @IBOutlet weak var txtConfirmPassword: HBOTextField!
    @IBOutlet weak var txtZipCode: HBOTextField!
    
    @IBOutlet weak var cbAgreement: HBOCheckBox!
    
    @IBOutlet weak var btnRegister: HBOButton!
    @IBOutlet weak var btnSignIn: HBOButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUIStyles()
    }
    
    private func configureUIStyles() {
        txtFirstName.layer.cornerRadius = 10
        txtFirstName.layer.maskedCorners = .layerMinXMinYCorner
        txtFirstName.setLeftPaddingPoints(10)
        txtFirstName.setRightPaddingPoints(10)
        
        txtLastName.layer.cornerRadius = 10
        txtLastName.layer.maskedCorners = .layerMaxXMinYCorner
        txtLastName.setLeftPaddingPoints(10)
        txtLastName.setRightPaddingPoints(10)
        
        txtEmailAddress.layer.cornerRadius = 10
        txtEmailAddress.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        txtEmailAddress.setLeftPaddingPoints(10)
        txtEmailAddress.setRightPaddingPoints(10)
        
        txtPassword.layer.cornerRadius = 10
        txtPassword.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        txtPassword.setLeftPaddingPoints(10)
        txtPassword.setRightPaddingPoints(10)
        
        txtConfirmPassword.layer.cornerRadius = 10
        txtConfirmPassword.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        txtConfirmPassword.setLeftPaddingPoints(10)
        txtConfirmPassword.setRightPaddingPoints(10)
        
        txtZipCode.layer.cornerRadius = CGFloat(10)
        txtZipCode.setLeftPaddingPoints(10)
        txtZipCode.setRightPaddingPoints(10)
        
    }
    
    @IBAction func onRegister(_ sender: HBOButton!) {
        Auth.auth().createUser(withEmail: txtEmailAddress.text!, password: txtPassword.text!) {
            authResult, error in
            let alert: UIViewController
            
            if (error != nil) {
                alert = AlertViewController.showAlert(header: "Registration Failed", body: (error?.localizedDescription)!, action: "Okay")
                
            } else {
                alert = AlertViewController.showAlert(header: "Registration Success", body: "Signup Successfully!, Please Sign In", action: "Okay")
            }
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}

