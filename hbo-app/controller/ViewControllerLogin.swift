//
//  ViewControllerLogin.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/14/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import UIKit

class ViewControllerLogin: UIViewController {
    @IBOutlet weak var subscriptionButton: UIButton!
    @IBOutlet weak var emailAddress: HBOTextField!
    @IBOutlet weak var password: HBOTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUIStyles()
    }
    
    private func configureUIStyles() {
        subscriptionButton.layer.cornerRadius = 5
        subscriptionButton.layer.borderWidth = 2
        subscriptionButton.layer.borderColor = UIColor.gray.cgColor
        
        emailAddress.layer.cornerRadius = 10
          emailAddress.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        password.layer.cornerRadius = 10
        password.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}
