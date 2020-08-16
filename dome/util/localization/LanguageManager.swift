//
//  LanguageManager.swift
//  iPay
//
//  Created by Chandana Pathirage on 5/17/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import UIKit

class LanguageManager: NSObject {
    var availableLocales = [CustomLocale]()
    static let sharedInstance = LanguageManager()
    var lprojBasePath = String()
    
    override init() {
        super.init()
        let english = CustomLocale(languageCode: "en", countryCode: "us", name: "United State")
        let arab  = CustomLocale(languageCode: "ar", countryCode: "IQ", name: "Arab")
        self.availableLocales = [english , arab]
        self.lprojBasePath =  getSelectedLocale()
    }
    
    
    func getSelectedLocale()->String{
        
        let lang = Locale.preferredLanguages//returns array of preferred languages
        let languageComponents: [String : String] = Locale.components(fromIdentifier: lang[0])
        if let languageCode: String = languageComponents["kCFLocaleLanguageCodeKey"]{
            
            for customlocale in availableLocales {
                
                if(customlocale.languageCode == languageCode){
                    
                    return customlocale.languageCode!
                }
            }
        }
        return "en"
    }
    
    func getCurrentBundle()->Bundle{
        
        if let bundle = Bundle.main.path(forResource: lprojBasePath, ofType: "lproj"){
            
            return Bundle(path: bundle)!
            
        }else{
            
            fatalError("lproj files not found on project directory. /n Hint:Localize your strings file")
        }
    }
    
    func setLocale(_ langCode:String){
        
        UserDefaults.standard.set([langCode], forKey: "AppleLanguages")//replaces Locale.preferredLanguages
        UserDefaults.standard.synchronize()
        self.lprojBasePath =  getSelectedLocale()
    }
}

class CustomLocale: NSObject {
    var name:String?
    var languageCode:String?
    var countryCode:String?
    
    init(languageCode: String,countryCode:String,name: String) {
        
        self.name = name
        self.languageCode = languageCode
        self.countryCode = countryCode
        
    }
    
}
