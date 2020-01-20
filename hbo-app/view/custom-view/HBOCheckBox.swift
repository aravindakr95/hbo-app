//
//  HBOCheckbox.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 1/18/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import UIKit

class HBOCheckBox: UIButton {
    let selectedCheckBox = UIImage(named: "check-box-selected")
    let unselectedCheckBox = UIImage(named: "check-box-unselected")
    
    var isChecked: Bool = false {
        didSet {
            self.setImage(
                self.isChecked ?  self.selectedCheckBox : self.unselectedCheckBox,
                for: UIControl.State.normal
            )
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
