//
//  TryMeScreen.swift
//  iPay
//
//  Created by Navoda on 9/6/18.
//  Copyright © 2018 iPay. All rights reserved.
//

import Foundation
import UIKit

class TryMeScreen: CustomRootViewController {
    
    @IBOutlet var btnLogin: IpayButton!
    @IBOutlet var btnRegister: IpayButton!
    @IBOutlet var btnTryMe: IpayButton!
    @IBOutlet var btnEn: UIButton!
    @IBOutlet var btnSin: UIButton!
    @IBOutlet var btnTam: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin.borderColor = UIColor(hexString: "00B9FF")
        btnLogin.borderWidth = 2
        
        self.btnEn.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1)
        self.btnEn.layer.cornerRadius = btnEn.bounds.size.width/2
        self.btnEn.layer.borderWidth = 3
        self.btnEn.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5).cgColor
        
        self.btnSin.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1)
        self.btnSin.layer.cornerRadius = btnSin.bounds.size.width/2
        self.btnSin.layer.borderWidth = 3
        self.btnSin.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5).cgColor
        
        self.btnTam.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1)
        self.btnTam.layer.cornerRadius = btnTam.bounds.size.width/2
        self.btnTam.layer.borderWidth = 3
        self.btnTam.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5).cgColor
        
//        btnTryMe.isHidden = true
        setLangButtonColor()
    }
    
    func setLangButtonColor() -> Void {
        let lang = LanguageManager.sharedInstance.getSelectedLocale()
        if lang == "en" {
            self.btnEn.backgroundColor = UIColor(red: 21/255, green: 170/255, blue: 222/255, alpha: 1)
//            btnEn.isEnabled = false
        } else if lang == "si" {
            self.btnSin.backgroundColor = UIColor(red: 21/255, green: 170/255, blue: 222/255, alpha: 1)
//            btnSin.isEnabled = false
        } else if lang == "ta" {
            self.btnTam.backgroundColor = UIColor(red: 21/255, green: 170/255, blue: 222/255, alpha: 1)
//            btnTam.isEnabled = false
        }
    }
    
    private func changeToLanguage(_ langCode: String) {
        LocalizationMain.setLanguage(language: langCode)
        LocalizationMain.getBundle()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.initTryMeView()
//        viewDidLoad()
    }
    
    //MARK: - btn action
    
    @IBAction func onTapBtnEn(_ sender: Any) {
        applyEnglishFont()
        changeToLanguage("en")
    }
    
    @IBAction func onTapBtnSin(_ sender: Any) {
//        applySinhalaFont()
        changeToLanguage("si")
    }
    
    @IBAction func onTapBtnTam(_ sender: Any) {
        applyEnglishFont()
        changeToLanguage("ta")
    }
    
    @IBAction func onTapBtnTryMe(_ sender: Any) {
        let mainView: UIStoryboard!  = UIStoryboard(name: "Main", bundle: nil)
        let navigator : UINavigationController = mainView.instantiateViewController(withIdentifier: "MainNavigatorScene") as! UINavigationController
        let viewcontroller : MainViewController = mainView.instantiateViewController(withIdentifier: "MainScene") as! MainViewController
        navigator.pushViewController(viewcontroller, animated: true)
        self.present(navigator, animated:true , completion: nil)
    }
    
    @IBAction func onTapRegister(_ sender: Any) {
        RegisterCommonViewController.regRequest = nil
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Register", bundle: nil)
        let viewcontroller : RegisterFirstScreen = storyBoard.instantiateViewController(withIdentifier: "RegisterFirst") as! RegisterFirstScreen
//        self.navigationController?.pushViewController(viewcontroller, animated: true)
        present((self.navigationController)!, animated:true , completion: nil)

//        let mainView: UIStoryboard!  = UIStoryboard(name: "Register", bundle: nil)
//        let navigator : UINavigationController = mainView.instantiateViewController(withIdentifier: "MainNavigatorScene") as! UINavigationController
//        let register : RegisterFirstScreen = mainView.instantiateViewController(withIdentifier: "RegisterFirst") as! RegisterFirstScreen
//        navigator.pushViewController(register, animated: true)
//        self.present(navigator, animated:true , completion: nil)
    }
    
    @IBAction func onTapLogin(_ sender: Any) {
        let mainView: UIStoryboard!  = UIStoryboard(name: "Main", bundle: nil)
        let navigator : UINavigationController = mainView.instantiateViewController(withIdentifier: "MainNavigatorScene") as! UINavigationController
        let login : LoginViewController = mainView.instantiateViewController(withIdentifier: "SignIn") as! LoginViewController
        navigator.pushViewController(login, animated: true)
        self.present(navigator, animated:true , completion: nil)
    }
    
}
