//
//  IpaySuccessMessageResponse.swift
//  iPay
//
//  Created by Navoda on 1/9/20.
//  Copyright © 2020 iPay. All rights reserved.
//

import Foundation

class IpaySuccessMessageResponse: NSObject{
    
    var successMessage : String?
    
    
    init?(json: [String: Any]) {
        
        guard let successMessage = json[PropertyKey.message] as? String else { return nil }
        
        self.successMessage = successMessage
        
    }
}
