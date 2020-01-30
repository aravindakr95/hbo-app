//
//  TransitionManager.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/30/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import UIKit

final class TransitionManager {
    public static func transition(sender: UIViewController, identifier: String) {
        DispatchQueue.main.async {
            sender.performSegue(withIdentifier: identifier, sender: sender)
        }
    }
}
