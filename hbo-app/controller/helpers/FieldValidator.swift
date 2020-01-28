//
//  FieldValidator.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/18/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import Foundation

final class FieldValidator {
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailPred.evaluate(with: email)
    }
    
    func isEqual(fieldOne: String, fieldTwo: String) -> Bool {
        return fieldOne == fieldTwo
    }
    
    func isEmpty(count: Int) -> Bool {
        return count > 0
    }
    
    func isValidLength(field: String, length: Int) -> Bool {
        return field.count >= length
    }
    
    func isMatch(fieldOne: HBOTextField, fieldTwo: HBOTextField? = nil) -> Bool {
        if fieldTwo?.text != nil {
            return fieldOne.text == fieldTwo?.text
        }
        
        return true
    }
    
    func validate(type: String, textField: HBOTextField, optionalField: HBOTextField? = nil) -> (Bool, String) {
        var isValid = false
        var validateData: (Bool, String) = (false, "")
        
        guard let text = textField.text else {
            return validateData
        }
        
        switch type {
        case "Email":
            isValid = isEmpty(count: text.count) && isValidEmail(email: text)
            validateData = (isValid, type)
        case "First Name", "Last Name", "Zip Code":
            isValid = isEmpty(count: text.count)
            validateData = (isValid, type)
        case "Password":
            isValid = isEmpty(count: text.count) && isMatch(fieldOne: textField, fieldTwo: optionalField) && isValidLength(field: text, length: 6)
            validateData = (isValid, type)
        default:
            break
        }
        
        return validateData
    }
    
    
    
}
