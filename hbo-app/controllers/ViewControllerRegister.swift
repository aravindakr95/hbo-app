//
//  ViewControllerRegister.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/12/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import UIKit

class ViewControllerRegister: UIViewController {
    
    @IBOutlet weak var euaCheckBox: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = UIBarStyle.black
    }
    
    @IBAction func euaButtonPressed(_ sender: UIButton) {
        if sender.isSelected == true {
            euaCheckBox.setImage(UIImage(named: "check-box-selected"), for: .normal)
            sender.isSelected = false
        } else  {
            euaCheckBox.setImage(UIImage(named: "check-box-unselected"), for: .normal)
            sender.isSelected = true
        }
    }
}

