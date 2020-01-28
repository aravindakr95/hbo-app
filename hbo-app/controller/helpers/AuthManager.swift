//
//  AuthManager.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/27/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import Foundation
import LocalAuthentication
import FirebaseAuth

final class AuthManager {
    public func createUser(emailField: HBOTextField, passwordField: HBOTextField, completion: @escaping (_ success: User?, _ error: String?) -> Void) {
        guard
            let email = emailField.text,
            let password = passwordField.text
            else { return }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: {(authResult, error) in
            if authResult?.user != nil {
                completion(authResult?.user, nil)
            } else {
                completion(nil, error?.localizedDescription)
            }
        })
    }
    
    public func signIn(emailField: HBOTextField, passwordField: HBOTextField, completion: @escaping (_ success: Bool?, _ error: String?) -> Void) {
        guard
            let email = emailField.text,
            let password = passwordField.text
            else { return }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: {(authResult, error) in
            if error != nil {
                completion(nil, error?.localizedDescription)
            } else {
                completion(true, nil)
            }
        })
    }
    
    public func signOut(completion: @escaping (_ success: Bool?, _ error: String?) -> Void) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            completion(true, nil)
        } catch let signOutError as NSError {
            completion(nil, "Error signing out: %@ \(signOutError)")
        }
    }
    
    public func currentUser(completion: @escaping (_ success: User?, _ error: String?) -> Void) {
        let currentUser = Auth.auth().currentUser
        
        if currentUser != nil {
            completion(currentUser!, nil)
        } else {
            completion(nil, "User expired or invalid")
        }
    }
    
    public func sendPasswordReset(emailField: HBOTextField, completion: @escaping (_ success: Bool?, _ error: String?) -> Void) {
        guard
            let email = emailField.text else { return }
        
        Auth.auth().sendPasswordReset(withEmail: email, completion: {error in
            if (error != nil) {
                completion(nil, error?.localizedDescription)
            } else {
                completion(true, nil)
            }
        })
    }
    
    public func authWithBioMetrics(completion: @escaping (_ success: Bool?, _ error: String?) -> Void) {
        let localAuthContext = LAContext()
        var error: NSError?
        
        if localAuthContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let biometricType = localAuthContext.biometryType == LABiometryType.faceID ? "Face ID" : "Touch ID"
            let reason = "Please authenticate using your \(biometricType)."
            
            localAuthContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason, reply:
                {(success, error) in
                    if error != nil {
                        completion(nil, error?.localizedDescription)
                    }
                    else {
                        completion(true, nil)
                    }
            })
        }
        else {
            completion(nil, "Device is not supported for Biometrics Authentication.")
        }
    }
}
