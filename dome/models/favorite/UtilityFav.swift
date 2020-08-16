//
//  UtilityFav.swift
//  iPay
//
//  Created by Thushara Wijekoon on 5/11/18.
//  Copyright © 2018 iPay. All rights reserved.
//

import Foundation
class UtilityFavResponse: NSObject {
    
    var favouriteId: Int?
    var utilityMerchantId: Int?
    var utilityMerchantName: String?
    var logo: String?
    var utilityCode: String?
    var utilityProviderId: Int = 0
    var referenceAccountLabel: String?
    var utilityAccountNo: String?
    
    override init(){}
    
    init?(json: [String: Any]) {
        super.init()
        guard let favouriteId = json[PropertyKey.favouriteId] as? Int,
            let utilityMerchantId = json[PropertyKey.utilityMerchantId] as? Int,
            let utilityMerchantName = json[PropertyKey.utilityMerchantName] as? String,
            let logo = json[PropertyKey.logo] as? String,
            let utilityCode = nullToString(value: (json[PropertyKey.utilityCode])! ),
            let utilityProviderId = json[PropertyKey.utilityProviderId] as? Int,
            let referenceAccountLabel = json[PropertyKey.referenceAccountLabel] as? String,
            let utilityAccountNo = json[PropertyKey.utilityAccountNo] as? String else { return nil }
        
        self.favouriteId = favouriteId
        self.utilityMerchantId = utilityMerchantId
        self.utilityMerchantName = utilityMerchantName
        self.logo = logo
        self.utilityCode = utilityCode
        self.utilityProviderId = utilityProviderId
        self.referenceAccountLabel = referenceAccountLabel
        self.utilityAccountNo = utilityAccountNo
        
    }
}
