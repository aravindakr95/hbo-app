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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscriptionButton.layer.cornerRadius = 5
        subscriptionButton.layer.borderColor = UIColor.gray.cgColor
        subscriptionButton.layer.borderWidth = 2
    }    
}
