//
//  SSLCertificateVerification.swift
//  iPay
//
//  Created by Chandana Pathirage on 3/23/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import UIKit

public class SSLCertificateVerification: NSObject, URLSessionDelegate{
    
    //    private let ipydevcert = "justpay_ssl"
//    private let ipydevcert = "ipay" // this is minio wildcard cert
    private let ipydevcert = "cambodiacert"
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//        let serverTrust = challenge.protectionSpace.serverTrust
//        let certificate = SecTrustGetCertificateAtIndex(serverTrust!, 0)
//
//        // Set SSL policies for domain name check
//        let policies = NSMutableArray();
//        policies.add(SecPolicyCreateSSL(true, (challenge.protectionSpace.host as CFString?)))
//        SecTrustSetPolicies(serverTrust!, policies);
//
//        // Evaluate server certificate
//        var result: SecTrustResultType = SecTrustResultType(rawValue: SecTrustResultType.invalid.rawValue)! // 0
//        SecTrustEvaluate(serverTrust!, &result)
//        let isServerTrusted:Bool = (Int(result.hashValue) == SecTrustResultType.unspecified.hashValue || Int(result.hashValue) == SecTrustResultType.proceed.hashValue)
//
//        print(result.hashValue)
//        print(result.hashValue)
//        print(SecTrustResultType.unspecified.hashValue)
//        print(SecTrustResultType.proceed.hashValue)
//
//        // Get local and remote cert data
//        let remoteCertificateData:NSData = SecCertificateCopyData(certificate!)
//        let pathToCert = Bundle.main.path(forResource: ipydevcert, ofType: "cer")
        
//        let localCertificate:NSData = NSData(contentsOfFile: pathToCert!)!
//        let remot = remoteCertificateData.isEqual(to: localCertificate as Data)
//        print("Remote: \(remot)")
//        print("isServerTusted: \(isServerTrusted)")
//        if (true && remoteCertificateData.isEqual(to: localCertificate as Data)) {
//            let credential:URLCredential = URLCredential(trust: serverTrust!)
//            completionHandler(.useCredential, credential)
//        } else {
//            completionHandler(.cancelAuthenticationChallenge, nil)
//        }
        
        ///////////////////public key pinning
        let pathToCert = Bundle.main.path(forResource: ipydevcert, ofType: "cer")
        let certificateData:NSData = NSData(contentsOfFile: pathToCert!)!
        let localCertificate = SecCertificateCreateWithData(kCFAllocatorDefault, certificateData)
        
        let serverTrust = challenge.protectionSpace.serverTrust!
        let serverPublicKey = SecTrustCopyPublicKey(serverTrust)
         var localTrust: SecTrust?
        
        // Set SSL policies for domain name check
        let policies = NSMutableArray();
        policies.add(SecPolicyCreateSSL(true, (challenge.protectionSpace.host as CFString?)))
        SecTrustSetPolicies(serverTrust, policies);
        
//        print(serverPublicKey)
//        print()
        
        if SecTrustCreateWithCertificates(localCertificate!, policies, &localTrust) == errSecSuccess {
//            let localPublicKey = SecTrustCopyPublicKey(localTrust!)!
//            print(localPublicKey)
            //ignore public key check 2020-04-06
//            if (localPublicKey as AnyObject).isEqual(serverPublicKey as AnyObject) {
                let credential:URLCredential = URLCredential(trust: serverTrust)
                return completionHandler(.useCredential, credential)
//            }
        }
        print("not trusted")
        return completionHandler(.cancelAuthenticationChallenge, nil)
    }
}
