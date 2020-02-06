//
//  CustomTableViewCell.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 2/5/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.


import UIKit
import SwiftyJSON
import Alamofire
import SafariServices

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var hboImageView: HBOImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hboImageView.layer.cornerRadius = 8
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
