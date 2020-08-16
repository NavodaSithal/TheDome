//
//  IpayLabel.swift
//  iPay
//
//  Created by Thushara Wijekoon on 11/23/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import UIKit

class IpayLabel :  UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        text = getLocalizedString(key: text!)
      
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        changeFontName()
    }
    
//    func changeFontName()
//    {
//        self.font = UIFont(name: "ProximaNovaCond-Regular", size: self.font.pointSize)
//    }
   
    
}



