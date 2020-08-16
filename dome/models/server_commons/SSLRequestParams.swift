//
//  SSLRequestParams.swift
//  iPay
//
//  Created by Thushara Wijekoon on 9/19/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import Foundation

class  SSLRequestParams : NSObject {
    
    var pair :NSObject = NSObject()
    var url :String?
    var accessToken : String?
    var reqType :  RequestType?
    var httpMethod :  HttpMethod?
    var callbackFunction: ((ResponseClass) -> Void)?
    
    
}
