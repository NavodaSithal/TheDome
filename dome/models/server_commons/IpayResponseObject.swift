//
//  IpayResponseObject.swift
//  iPay
//
//  Created by Thushara Wijekoon on 9/25/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import Foundation

class IpayResponseObject: NSObject{
    
    var responseCode : String?
    var responseObject : [String: Any]?
    
    
    init?(json: [String: Any]) {
        
        guard let responseCode = json[PropertyKey.responseCode] as? String ,
            let responseObject = json[PropertyKey.responseObject] as? [String: Any] else { return nil }
        
        self.responseCode = responseCode
        self.responseObject = responseObject
        
    }
}
