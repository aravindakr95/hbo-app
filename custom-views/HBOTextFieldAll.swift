//
//  HBOTextFieldAll.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/13/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import Foundation
import UIKit

class HBOTextFieldAll: UITextField {
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
        layer.cornerRadius  = CGFloat(10)
    }
    
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
