//
//  LanguageVC.swift
//  iPay
//
//  Created by Thushara Wijekoon on 8/15/20.
//  Copyright © 2020 iPay. All rights reserved.
//

import UIKit

class LanguageVC: CustomRootViewController {
   
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
        performSegue(withIdentifier: "lang_to_second", sender: nil)
    }
    
    @IBAction func clickArab(_ sender: Any) {
    }
}
