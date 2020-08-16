//
//  RegisterPopupViewController.swift
//  iPay
//
//  Created by Navoda on 9/10/18.
//  Copyright © 2018 iPay. All rights reserved.
//

import Foundation
import UIKit

protocol registerPopupButtonDelegate {
    func onTapBtnOne (btnOneCallbackIndex : Int)
    func onTapBtnTwo (btnTwoCallbackIndex : Int)
    func onTapClose (btnCloseCallbackIndex : Int)
    
}

class RegisterPopupViewController: CustomRootViewController {
    
    @IBOutlet var lblMsg: IpayLabel!
        @IBOutlet var lbltitle: IpayLabel!
        @IBOutlet var btnClose: UIButton!
        @IBOutlet var btnLogin: IpayButton!
        @IBOutlet var btnregister: IpayButton!
        @IBOutlet var imgIcon: UIImageView!
        
        public var mainTitle : String = ""
        public var message : String = ""
        public var btnOneText : String = ""
        public var btnTwoText : String = ""
        public var popUpType : Int = 0
        
        var btnClickDelegate : registerPopupButtonDelegate? = nil
        var btnOneCallbackIndex : Int = 0
        var btnTwoCallbackIndex : Int = 0
        var btnCloseCallbackIndex : Int = 0

        override func viewDidLoad() {
            super.viewDidLoad()
            
            btnregister.cornerRadius = 10
            btnLogin.cornerRadius = 10
            btnLogin.borderWidth = 2
            btnLogin.borderColor = UIColor(hexString: "1FBFDB")
            
            lbltitle.text = mainTitle
            lblMsg.text = message
            btnLogin.setTitle(btnOneText, for: .normal)
            btnregister.setTitle(btnTwoText, for: .normal)
            
    //        popuptype = 0 - tryme
    //        popuptype = 1 - smsverify and call

            if popUpType == 0 {
    //            btnLogin.borderColor = UIColor(hexString: "1FBFDB")
                btnregister.backgroundColor = UIColor(hexString: "0096FF")
                lbltitle.textColor = UIColor(hexString: "0096FF")
                btnLogin.backgroundColor = UIColor(hexString: "31BA74")
                btnLogin.setTitleColor(UIColor.white, for: .normal)
                btnLogin.borderColor = UIColor.white
                imgIcon.image = UIImage(named: "info")
            } else if popUpType == 1 {
                btnClose.isHidden = true
                btnLogin.borderColor = UIColor(hexString: "0096FF")
                btnregister.backgroundColor = UIColor(hexString: "0096FF")
                lbltitle.textColor = UIColor(hexString: "0096FF")
                btnLogin.setTitleColor(UIColor(hexString: "0096FF"), for: .normal)
                imgIcon.image = UIImage(named: "contact_ipay")
            }
            else if popUpType == 2 {
                btnClose.isHidden = true
                btnLogin.borderColor = UIColor(hexString: "FFB833")
                btnregister.backgroundColor = UIColor(hexString: "FFB833")
                lbltitle.textColor = UIColor(hexString: "FFB833")
                btnLogin.setTitleColor(UIColor(hexString: "FFB833"), for: .normal)
                imgIcon.image = UIImage(named: "sms")
            }
        }
        
        @IBAction func onTapregister(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
           btnClickDelegate?.onTapBtnTwo(btnTwoCallbackIndex: btnTwoCallbackIndex)
        }
        
        @IBAction func onTapLogin(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
            btnClickDelegate?.onTapBtnOne(btnOneCallbackIndex: btnOneCallbackIndex)
        }
        
        @IBAction func onTapClose(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
            btnClickDelegate?.onTapClose(btnCloseCallbackIndex: btnCloseCallbackIndex)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
