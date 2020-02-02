//
//  UserProfile.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 2/2/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import Foundation

struct UserProfile {
    var firstName: String
    var lastName: String
    var zipCode: Int
    var auth: AuthData
}

struct AuthData {
    var email: String
    var password: String
}
