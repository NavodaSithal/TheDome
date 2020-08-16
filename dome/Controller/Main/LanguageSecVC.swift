//
//  LanguageSecVC.swift
//  iPay
//
//  Created by Thushara Wijekoon on 8/16/20.
//  Copyright © 2020 iPay. All rights reserved.
//

import UIKit

class LanguageSecVC: CustomRootViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        //       if let text = Bundle.main.infoDictionary?["CFBundleShortVersionString"]  as? String {
        //           tvVersion.text = getLocalizedString(key: "version") + " \(text)"
        //       }
        //
        //       let lang = LanguageManager.sharedInstance.getSelectedLocale()
        //       if lang == "en" {
        //           applyEnglishFont()
        //       }
        //       else if lang == "km" {
        //           applyKhmerFont()
        //       }
    }
    
    @IBAction func clickEnglish(_ sender: Any) {
        LocalizationMain.setLanguage(language: "en")
        switchViewControllers(isArabic : false)
        
    }
    
    @IBAction func clickArab(_ sender: Any) {
        LocalizationMain.setLanguage(language: "ar")
        switchViewControllers(isArabic : true)
    }
    
    
    func switchViewControllers(isArabic arabic : Bool){
        UIView.appearance().semanticContentAttribute = arabic ? .forceRightToLeft : .forceLeftToRight
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        LocalizationMain.getBundle()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainNavigator : UINavigationController = storyboard.instantiateViewController(withIdentifier: "SplashNavigatorScene") as! UINavigationController
        //            let viewcontroller : UIViewController = storyboard.instantiateViewController(withIdentifier: "LanguageSec") as UIViewController
        //            mainNavigator.pushViewController(viewcontroller, animated: true)
        appDelegate!.window?.rootViewController = mainNavigator
        
    }
}
