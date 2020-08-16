//
//  PhoneTextField.swift
//  iPay
//
//  Created by iPay Sri lanka on 2/6/18.
//  Copyright © 2018 iPay. All rights reserved.
//

import UIKit

class PhoneTextField: UITextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        placeholder = getLocalizedString(key: placeholder!)}
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     UIEdgeInsetsMake(1, 5, 0, 10))
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     UIEdgeInsetsMake(1, 5, 0, 10))
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     UIEdgeInsetsMake(1, 5, 0, 10))
    }

}
