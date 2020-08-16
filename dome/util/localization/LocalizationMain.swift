//
//  LocalizationMain.swift
//  iPay
//
//  Created by Thushara Wijekoon on 11/23/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import Foundation
class LocalizationMain : NSObject{
    private static var bundle: Bundle? = nil
    
    static func setLanguage(language: String) -> Void {
        let l = language as String;
        //        print(l)
        LanguageManager.sharedInstance.setLocale(l)
        //        getBundle()
    }
    
    static func getBundle(){
        var langCode  = LanguageManager.sharedInstance.getSelectedLocale()
        if langCode.count == 0 {
            langCode = "ar"
        }
        
        var forResource: String!
        if langCode == "ar" {
            forResource = "ar_IQ"
        }else {
            forResource = "en"
        }
        //        print(langCode)
        
        let path: String? = Bundle.main.path(forResource: forResource, ofType: "lproj")
        
        if path == nil {
            LocalizationMain.bundle = Bundle.main
        }
        else {
            LocalizationMain.bundle = Bundle(path: path!)
        }
    }
    
    static func localizedString(forKey key: String) -> String {
        return LocalizationMain.bundle!.localizedString(forKey: key, value: "", table: nil)
    }
}

func getLocalizedString(key: String) -> String {
    return LocalizationMain.localizedString(forKey: (key))
}
