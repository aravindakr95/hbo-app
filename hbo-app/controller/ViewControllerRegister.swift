//
//  ViewControllerRegister.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/12/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import UIKit

class ViewControllerRegister: UIViewController {
    @IBOutlet weak var txtFirstName: HBOTextField!
    @IBOutlet weak var txtLastName: HBOTextField!
    @IBOutlet weak var txtEmailAddress: HBOTextField!
    @IBOutlet weak var txtPassword: HBOTextField!
    @IBOutlet weak var txtConfirmPassword: HBOTextField!
    @IBOutlet weak var txtZipCode: HBOTextField!
    
    @IBOutlet weak var cbAgreement: UIButton!
    
    @IBOutlet weak var btnRegister: HBOButton!
    @IBOutlet weak var btnSignIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUIStyles()
    }
    
//    var isChecked:Bool = false{
//        didSet{
//            if isChecked {
//                self.setImage(selectedImage, forState: UIControlState.Normal)
//            }else{
//                self.setImage(unselectedImage, forState: UIControlState.Normal)
//            }
//        }
//    }
    
    private func configureUIStyles() {
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        txtFirstName.layer.cornerRadius = 10
        txtFirstName.layer.maskedCorners = .layerMinXMinYCorner
        
        txtLastName.layer.cornerRadius = 10
        txtLastName.layer.maskedCorners = .layerMaxXMinYCorner
        
        txtLastName.layer.cornerRadius = 10
        txtLastName.layer.maskedCorners = .layerMaxXMinYCorner
        
        txtEmailAddress.layer.cornerRadius = 10
        txtEmailAddress.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        txtPassword.layer.cornerRadius = 10
        txtPassword.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        txtConfirmPassword.layer.cornerRadius = 10
        txtConfirmPassword.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        txtZipCode.layer.cornerRadius = CGFloat(10)
    }
    
    @IBAction func onCbAgreementBtnPressed(_ sender: UIButton) {
        if sender.isSelected == true {
            cbAgreement.setImage(UIImage(named: "check-box-selected"), for: .normal)
            sender.isSelected = false
        } else  {
            cbAgreement.setImage(UIImage(named: "check-box-unselected"), for: .normal)
            sender.isSelected = true
        }
    }
}

