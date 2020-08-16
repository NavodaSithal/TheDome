//
//  AuthenticationManager.swift
//  iPay
//
//  Created by Chandana Pathirage on 3/25/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import UIKit
import SystemConfiguration

public class AuthenticationManager: NSObject , clickPopupButtonDelegate{
   
    func onTapBtnOne(btnOneCallbackIndex: Int) {
        
    }
    
    func onTapBtnTwo(btnTwoCallbackIndex: Int) {
    }
    
    func onTapClose(btnCloseCallbackIndex: Int) {
        
    }
    
    
    // getting unique device id
    private let uusid: String?
    public let settings: Settings?
    private let que: DispatchQueue?
    private var loginStates: Bool = false
    //    private var res: Bool = false
    private var uiViewController: UIViewController?
    var customActivityIndicator: CustomActivityIndicator!
    var comManager : SslCommunicationManager? = nil
    private var totalNoOfChallenges : Int = 0
    private var currentChallengeValue : Int = 0
    var currentSignedMandtesCount = 0
    static var showSeqQuestionView : Bool = false
    private let customerRegisterSuccessCallback = 1
    private let customerActivateSuccessCallback = 2
    private let logoutIndex = 3
    static let id = "group.com.ipay.mobile.cam"

    init(uiViewController: UIViewController, comMan : SslCommunicationManager) {
        
        self.uiViewController = uiViewController
        self.uusid = UIDevice.current.identifierForVendor!.uuidString
        self.settings = Settings()
        self.que = DispatchQueue(label: "ipay")
        customActivityIndicator = CustomActivityIndicator()
        self.comManager = comMan
        super.init()
    }
    
    
    func getCustomActivityIndicator() -> CustomActivityIndicator {
        return customActivityIndicator
    }
    
    func getUIViewController() -> UIViewController {
        return uiViewController!
    }
    
    
    
    //MARK:- shared
    
    func getURL(url: String) -> NSURL {
        return NSURL(string: url)!
    }
    
    func getDictionary(data: Data) -> NSDictionary {
        var nsDictionary: NSDictionary?
        do{
            nsDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
        }catch{
            //Response Data JOSN Serialization Error
            print("JSON ERROR: \(error)")
        }
        if nsDictionary != nil {
            return nsDictionary!
        } else {
            return NSDictionary()
        }
    }
    
    func showErrorPopup (errorTitle : String , errorMessage: String, btnText : String,  popUpType : Int, clickDelegate : clickPopupButtonDelegate, callbackIndex : Int) -> Void {
           DispatchQueue.main.async {
               let storyboard = UIStoryboard(name: "Setting", bundle: nil)
               let errorPopup: ErrorPopupViewController = storyboard.instantiateViewController(withIdentifier: "errorPopup") as! ErrorPopupViewController
               errorPopup.btnText = btnText
               //                errorPopup.isError = isError
               errorPopup.titleMessege = errorTitle
               errorPopup.errorMessage = errorMessage
               errorPopup.clickDelegate = clickDelegate
               errorPopup.callbackIndex = callbackIndex
               errorPopup.popUpType = popUpType
               errorPopup.modalPresentationStyle = .overFullScreen
               errorPopup.modalTransitionStyle = .crossDissolve
               
               if var topController = UIApplication.shared.keyWindow?.rootViewController {
                   while let presentedViewController = topController.presentedViewController {
                       topController = presentedViewController
                   }
                   
                   // topController should now be your topmost view controller
                   if topController.presentedViewController == nil {
                       self.uiViewController?.present(errorPopup, animated: false, completion:  nil)
                   }
               }
               
           }
       }
       
       func showTwoButtonPopup (mainTitle : String , message: String, btnOneText : String, btnTwoText : String, iconName : String, onPressButtonOne : (() -> Void)?, onPressButtonTwo : (() -> Void)?) -> Void {
           DispatchQueue.main.async {
               let storyboard = UIStoryboard(name: "Setting", bundle: nil)
               let errorPopup: TwoButtonPopupVC = storyboard.instantiateViewController(withIdentifier: "twoButtonVc") as! TwoButtonPopupVC
               errorPopup.btnOneText = btnOneText
               errorPopup.btnTwoText = btnTwoText
               
               errorPopup.mainTitle = mainTitle
               errorPopup.message = message
               errorPopup.iconName = iconName
               
               errorPopup.onPressButtonOne = onPressButtonOne
               errorPopup.onPressButtonTwo = onPressButtonTwo
               
               if var topController = UIApplication.shared.keyWindow?.rootViewController {
                   while let presentedViewController = topController.presentedViewController {
                       topController = presentedViewController
                   }
                   if topController.presentedViewController == nil {
                       self.uiViewController?.present(errorPopup, animated: false, completion:  nil)
                       
                   }
               }
           }
       }
       
    
    func saveAccessToken(accessToken: String) -> Void {
        UserDefaults.standard.set(accessToken, forKey: "access_token")
        UserDefaults.standard.synchronize()
    }
    
    func getUserName() -> String {
        let userName = UserDefaults.standard.object(forKey: "userName")
        if userName != nil {
            return userName as! String
        } else {
            return ""
        }
    }
    
    func removePinCode() -> Void {
        UserDefaults.standard.removeObject(forKey: "pincode")
    }
    
    func getSettings() -> Settings {
        return settings!
    }
    
    
    func clickButton(callBackIndex: Int) {
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
