//
//  IpayButton.swift
//  iPay
//
//  Created by Thushara Wijekoon on 11/23/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import UIKit
@IBDesignable

class IpayButton : UIButton {
    @IBInspectable var BtnCornerRadius: CGFloat = 10{
        didSet {setCornerRadius()}
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setTitle(getLocalizedString(key: (titleLabel?.text)!), for: .normal)
        setCornerRadius()
    }
    
    func setCornerRadius(){
        self.cornerRadius = BtnCornerRadius

    }
    
}
