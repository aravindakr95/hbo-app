//
//  HBOButton.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/12/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import UIKit

class HBOButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        clipsToBounds = true
        layer.cornerRadius  = CGFloat(8)
    }
}

