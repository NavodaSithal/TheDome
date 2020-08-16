//
//  IpayNavigationItem.swift
//  iPay
//
//  Created by Thushara Wijekoon on 11/27/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import UIKit
class IpayNavigationItem : UINavigationItem {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        title = getLocalizedString(key: title! )
        
    }
}
