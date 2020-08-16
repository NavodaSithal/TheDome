//
//  IpayBarButtonItem.swift
//  iPay
//
//  Created by Thushara Wijekoon on 3/12/18.
//  Copyright © 2018 iPay. All rights reserved.
//

import UIKit

class IpayBarButtonItem : UIBarButtonItem {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        title = getLocalizedString(key: title! )
    }
}
