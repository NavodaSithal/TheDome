//
//  IpayTabBarButton.swift
//  iPay
//
//  Created by Thushara Wijekoon on 2/23/18.
//  Copyright © 2018 iPay. All rights reserved.
//

import UIKit

class IpayTabBarButton : UITabBarItem {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor(hexString: "646A86")], for: .selected)
        title = getLocalizedString(key: title! )
    }
    
}
