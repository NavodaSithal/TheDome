//
//  SslCommunicationManager.swift
//  iPay
//
//  Created by Thushara Wijekoon on 9/14/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit

class SslCommunicationManager{
    public static var isRefreshCall : Bool = false
    
    
    func invokeRestService(sslReqParams : SSLRequestParams,authManager: AuthenticationManager) {
//        print(sslReqParams.url!)
        if isConnectedToNetwork(){
            DispatchQueue.global(qos: .background).async {
                // print("This is run on the background queue"
                //                let urlStr : NSString = sslReqParams.url!.addingPercentEscapes(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as NSString
                let urlStr = sslReqParams.url!
                let url : NSURL = NSURL(string: urlStr )!
                let request = NSMutableURLRequest(url: url as URL)
                
                request.httpMethod = (sslReqParams.httpMethod?.rawValue)!
                
                if sslReqParams.reqType == RequestType.NORMAL {
                    request.setValue("Bearer \(sslReqParams.accessToken ?? "")", forHTTPHeaderField: "Authorization")
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }else{
                    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                    request.setValue("application/json", forHTTPHeaderField: "Accept")
                }
                
                if(sslReqParams.httpMethod == HttpMethod.POST || sslReqParams.httpMethod == HttpMethod.PUT){
                    var dataSet = ""
                    if sslReqParams.reqType == RequestType.NORMAL {
                        let json1 = CustomJSONSerializer.toJson(sslReqParams.pair as Any)
                        dataSet += json1
//                        print(json1)
                        request.httpBody = dataSet.data(using: String.Encoding.utf8)!
                        
                    }else{
                        let clientID = (authManager.settings?.getClientId())! as String
                        let clientSecret = (authManager.settings?.getClientSecret())! as String
                        
                        dataSet  += "\(clientID )&\(clientSecret)&"
                        
                        
                        request.httpBody = dataSet.data(using: String.Encoding.utf8)!

//                        print(dataSet)
//                        print(request.httpBody.)
                    }
                    //                    print(dataSet)

                }
                
                let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: SSLCertificateVerification(), delegateQueue: nil)
                
                let task = urlSession.dataTask(with: request as URLRequest){
                    (data, response, error) -> Void in
                    
                    DispatchQueue.main.async {
                        if error != nil {
//                            print(error)
                            let err = error! as NSError
                            if(err.code == -999){
                                // this error comes when wifi has, but no internet situaltion and invalid ssh public key also
                                self.showUpdateMessage(authManager: authManager)
                            }else{
                                let errorObject = ["errorCode" : "111 " ,"errorMessage" : getLocalizedString(key: "error_server")]
                                let errJsonArray = ["responseCode" : "0" ,"responseObject" : errorObject] as [String : Any]
                                let resp = ResponseClass( responseCode: 0, responseObject: errJsonArray)
                                sslReqParams.callbackFunction!(resp)
                            }
                        }else{
                            if let httpResponse = response as? HTTPURLResponse {
                                if(httpResponse.statusCode == 200){
                                        if data != nil {
                                            if let data = data{
                                                if let rawJSON = try? JSONSerialization.jsonObject(with:data){
                                                    if let json = rawJSON as? [String: Any]{
//                                                        print("response \(json)")
                                                        let resp = ResponseClass( responseCode: 200, responseObject: json)
                                                        sslReqParams.callbackFunction!(resp)
                                                    }
                                                }
                                            }
                                        }
                                }else{
                                    let errorObject =  ["errorCode" : "111 " ,"errorMessage" : getLocalizedString(key: "error_server")]
                                    let errJsonArray = ["responseCode" : "0" ,"responseObject" : errorObject] as [String : Any]
                                    let resp = ResponseClass( responseCode: httpResponse.statusCode , responseObject:errJsonArray)
                                    //                                    print("response error")
                                    sslReqParams.callbackFunction!(resp)
                                }
                            }
                        }
                    }
                }
                task.resume()
            }
        }
        else{
            let errorObject =  ["errorCode" : "7777" ,"errorMessage" : getLocalizedString(key: "error_internet_connection")]
            let errJsonArray = ["responseCode" : "7777" ,"responseObject" : errorObject] as [String : Any]
            let resp = ResponseClass( responseCode: 7777 , responseObject:errJsonArray)
            sslReqParams.callbackFunction!(resp)
        }
        
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        //         Only Working for WIFI
        //         let isReachables = flags == .reachable
        //         let needsConnections = flags == .connectionRequired
        
        //         return isReachable && !needsConnection
        
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        let ret = (isReachable && !needsConnection)
//        print(ret)
        return ret
        
    }
    
    public func showUpdateMessage(authManager: AuthenticationManager){
        let refreshAlert = UIAlertController(title:getLocalizedString(key: "update_app_title") , message: getLocalizedString(key: "update_required"), preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: getLocalizedString(key: "update"), style: .default, handler: { (action: UIAlertAction!) in
            if let url = URL(string: "itms://itunes.apple.com/lk/app/ipay-cambodia/id1455091900?ls=1"),
                UIApplication.shared.canOpenURL(url) {
                //                  UserDefaults.standard.removeObject(forKey: "favorite") // for this release only- 14-12-2017
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }))
        
        authManager.getUIViewController().present(refreshAlert, animated: false, completion: nil)
    }
}

