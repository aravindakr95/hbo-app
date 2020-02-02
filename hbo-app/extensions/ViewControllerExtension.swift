//
//  ViewControllerExtension.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/30/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import UIKit

extension UIViewController : UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    public func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
