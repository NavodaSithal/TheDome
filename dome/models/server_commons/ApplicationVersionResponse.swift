//
//  ApplicationVersionResponse.swift
//  iPay
//
//  Created by Thushara Wijekoon on 11/17/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import Foundation
class ApplicationVersionResponse : NSObject {
    var applicationType : String?
    var applicationVersion : String?
    var applicationStatus : String?
    var effectiveDate : String?
    var releaseNote : String?
    var releaseType : String?
    var lastMajorReleaseVersion : String?
    
    init?(json: [String: Any]) {
        
        guard let applicationType = json[PropertyKey.applicationType] as? String ,
            let applicationVersion = json[PropertyKey.applicationVersion] as? String ,
            let applicationStatus = json[PropertyKey.applicationStatus] as? String ,
            let effectiveDate = json[PropertyKey.effectiveDate] as? String ,
            let releaseNote = json[PropertyKey.releaseNote] as? String ,
            let releaseType = json[PropertyKey.releaseType] as? String ,
            let lastMajorReleaseVersion = json[PropertyKey.lastMajorReleaseVersion] as? String   else { return nil }
        
        self.applicationType = applicationType
        self.applicationVersion = applicationVersion
        self.applicationStatus = applicationStatus
        self.effectiveDate = effectiveDate
        self.releaseNote = releaseNote
        self.releaseType = releaseType
        self.lastMajorReleaseVersion = lastMajorReleaseVersion
        
    }
}
