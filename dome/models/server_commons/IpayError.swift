//
//  IpayError.swift
//  iPay
//
//  Created by Thushara Wijekoon on 9/28/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import Foundation

class IpayError : NSObject{
    var errorCode : String?
    var errorMessage : String?
    
    init?(json: [String: Any]) {
        
        guard let errorCode = json[PropertyKey.errorCode] as? String ,
            let errorMessage = json[PropertyKey.errorMessage] as? String  else { return nil }

        self.errorCode = errorCode
        self.errorMessage = errorMessage
        
    }
    
}
