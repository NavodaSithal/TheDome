 //
 //  SplashViewController.swift
 //  iPay
 //
 //  Created by Thushara Wijekoon on 3/14/18.
 //  Copyright © 2018 iPay. All rights reserved.
 //
 
 import UIKit
 
 class SplashViewController: CustomRootViewController {
    
    @IBOutlet weak var tvVersion: UILabel!
    
    var isBackground : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
//        if let text = Bundle.main.infoDictionary?["CFBundleShortVersionString"]  as? String {
//            tvVersion.text = getLocalizedString(key: "version") + " \(text)"
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // code to remove your view
            self.performSegue(withIdentifier: "splash_to_language", sender: nil)
        }
    }
    
    func checkVersion(token : String) {
        let sslParam : SSLRequestParams = SSLRequestParams()
        sslParam.accessToken = token
        sslParam.httpMethod = HttpMethod.GET
        sslParam.reqType  = RequestType.NORMAL
        sslParam.url = rootAuthManager?.settings?.getCurrentVersionURL()
        
        sslParam.callbackFunction = { (responseObj ) in
            DispatchQueue.main.async {
                let ref : IpayResponseObject = IpayResponseObject(json: responseObj.responseObject)!
                if responseObj.responseCode == 200 {
                    if ref.responseCode == "000" {
                    }
                }else if responseObj.responseCode == 7777{
                    let err : IpayError = IpayError(json: ref.responseObject!)!
                    self.rootAuthManager?.showErrorPopup(errorTitle: getLocalizedString(key: "oops"), errorMessage: err.errorMessage!,btnText: getLocalizedString(key: "retry"), popUpType : 3, clickDelegate : self, callbackIndex : 3 )
                }
                    //                else if responseObj.responseCode == 0 {
                    //                   self.showUpdateMessage(message: "whdfhcgsdvj", requiredUpdate :true,tempToken: token)
                    //                }
                else{
                    let err : IpayError = IpayError(json: ref.responseObject!)!
                    self.rootAuthManager?.showErrorPopup(errorTitle: getLocalizedString(key: "error"), errorMessage: err.errorMessage!,btnText: getLocalizedString(key: "retry"), popUpType : 0, clickDelegate : self, callbackIndex : 3 )
                }
            }
        }
        self.comManager?.invokeRestService(sslReqParams: sslParam, authManager: rootAuthManager!)
    }
    
    override func clickButton(callBackIndex: Int) {
    }
 }
