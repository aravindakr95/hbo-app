//
//  TransitionController.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/27/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import UIKit

class TransitionController {
    public static func transition(selfView: UIView, sbName: String, identifier: String) {
        let viewController = UIStoryboard(name: sbName, bundle: nil).instantiateViewController(withIdentifier: identifier)
        selfView.window?.rootViewController = viewController
        
        selfView.window?.makeKeyAndVisible()
    }
}
