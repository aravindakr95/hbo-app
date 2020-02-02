//
//  TransitionManager.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/30/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import UIKit

final class TransitionManager {
    public static func transitionSegue(sender: UIViewController, identifier: String) {
        sender.performSegue(withIdentifier: identifier, sender: sender)
    }
    
    public static func pushViewController(storyBoardName: String, vcIdentifier: String, context: UINavigationController) {
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: vcIdentifier)
        
        context.pushViewController(vc, animated: true)
    }
    
    public static func popToViewController(storyBoardName: String, vcIdentifier: String, context: UINavigationController) {
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: vcIdentifier)
        
        context.popToViewController(vc, animated: true)
    }
    
    public static func popToRootViewController(context: UINavigationController) {
        context.popToRootViewController(animated: true)
    }
}
