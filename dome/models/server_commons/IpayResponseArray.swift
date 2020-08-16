//
//  IpayResponseArray.swift
//  iPay
//
//  Created by Thushara Wijekoon on 10/4/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import Foundation

class IpayResponseArray: NSObject{
    
    var responseCode : String?
    var responseObject : [Dictionary<String, Any>]?
    
    
    init?(json: [String: Any]) {
        
        guard let responseCode = json[PropertyKey.responseCode] as? String ,
            let responseObject = json[PropertyKey.responseObject] as? [Dictionary<String, Any>]  else { return nil }
        
        self.responseCode = responseCode
        self.responseObject = responseObject
        
    }
}
