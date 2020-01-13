//
//  HBOTextFieldTopLeft.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/13/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import Foundation
import UIKit

class HBOTextFieldTopLeft: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    
    private func setupTextField() {
        clipsToBounds = true
        layer.cornerRadius  = 10
        layer.maskedCorners = .layerMinXMinYCorner
    }
    
}
