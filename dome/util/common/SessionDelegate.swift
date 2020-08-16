//
//  SessionDelegate.swift
//  iPay
//
//  Created by Thushara Wijekoon on 5/23/18.
//  Copyright © 2018 iPay. All rights reserved.
//

import Foundation

//class SessionDelegate : NSObject, URLSessionDelegate {
//
//    private static let rsa2048Asn1Header:[UInt8] = [
//        0x30, 0x82, 0x01, 0x22, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
//        0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0f, 0x00
//    ];
//
//    private static let google_com_pubkey = ["4xVxzbEegwDBoyoGoJlKcwGM7hyquoFg4l+9um5oPOI="];
//    private static let google_com_full = ["KjLxfxajzmBH0fTH1/oujb6R5fqBiLxl0zrl2xyFT2E="];
//
//    func urlSession(_ session: URLSession,
//                    didReceive challenge: URLAuthenticationChallenge,
//                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//
//        let serverTrust = challenge.protectionSpace.serverTrust;
//
//        // Set SSL policies for domain name check
//        let policies = NSMutableArray();
//        policies.add(SecPolicyCreateSSL(true, (challenge.protectionSpace.host as CFString)));
//        SecTrustSetPolicies(serverTrust!, policies);
//
//        // Evaluate server certificate
//        var result = SecTrustResultType.invalid;
//        SecTrustEvaluate(serverTrust!, &result)
//        var isServerTrusted = result == .unspecified || result == .proceed ? true : false;
//
//        if(isServerTrusted && challenge.protectionSpace.host == "www.google.com") {
//            let certificate = SecTrustGetCertificateAtIndex(serverTrust!, 0);
//            //Compare public key
//            if #available(iOS 10.0, *) {
//                let policy = SecPolicyCreateBasicX509();
//                let cfCertificates = [certificate] as CFArray;
//
//                var trust: SecTrust?
//                SecTrustCreateWithCertificates(cfCertificates, policy, &trust);
//
//                let pubKey = SecTrustCopyPublicKey(trust!);
//
//                var error:Unmanaged<CFError>?
//                if let pubKeyData = SecKeyCopyExternalRepresentation(pubKey!, &error) {
//                    var keyWithHeader = Data(bytes: SessionDelegate.rsa2048Asn1Header);
//                    keyWithHeader.append(pubKeyData as Data);
//                    let sha256Key = sha256(keyWithHeader);
//                    if(!SessionDelegate.google_com_pubkey.contains(sha256Key)) {
//                        isServerTrusted = false;
//                    }
//                } else {
//                    isServerTrusted = false;
//                }
//            } else { //Compare full certificate
//                let remoteCertificateData = SecCertificateCopyData(certificate!) as Data;
//                let sha256Data = sha256(remoteCertificateData);
//                if(!SessionDelegate.google_com_full.contains(sha256Data)) {
//                    isServerTrusted = false;
//                }
//            }
//        }
//
//        if(isServerTrusted) {
//            let credential = URLCredential(trust: serverTrust!);
//            completionHandler(.useCredential, credential);
//        } else {
//            completionHandler(.cancelAuthenticationChallenge, nil);
//        }
//
//    }
//
//    func sha256(_ data : Data) -> String {
//        let CC_SHA256_DIGEST_LENGTH  = 64
//        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
//        data.withUnsafeBytes {
//            _ = CC_SHA256($0, CLong(data.count), &hash)
//        }
//        return Data(bytes: hash).base64EncodedString();
//    }
//
//}
