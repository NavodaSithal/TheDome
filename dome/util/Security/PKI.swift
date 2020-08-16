//
//  File.swift
//  CryptoiOS
//
//  Created by Sinnathamby Shanmugarajah on 4/10/17.
//  Copyright © 2017 mBrain. All rights reserved.
//

import Foundation
import UIKit
import CoreFoundation
import Security


public class PKI {

    
    // If the key is already generated get the key else create a new key
    func getPublicKeyAsBase64String(identifier:String) -> String!  {
        var strPublicKey : String? = nil
        if let publicKeyInKeyChain = getPublicKey(identifier: identifier) {
            strPublicKey = publicKeyInKeyChain
        }
        else {
            if let publicKeyNew = createKeyPair(identifier: identifier) {
                strPublicKey = publicKeyNew
            }
        }
        
        let s = encryptMessage(message: "shan the man", identifier: identifier)
        
        print(s)
        
        return strPublicKey
    }
    
    // Get the key from the keyChain if found else return nil
    func getPublicKey(identifier:String) -> String? {
        var dataPtr: AnyObject?
        var statusCode: OSStatus
        
        //print(encryptMessage(message: "shan", identifier: identifier))
        
        let PUBLIC_KEY = "iPay.publickey." + identifier
        
        let query: [NSString: Any] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: PUBLIC_KEY,
            kSecReturnData: NSNumber(value: true)
        ]
        
        statusCode = SecItemCopyMatching(query as CFDictionary, &dataPtr)
        
        if statusCode == noErr {
            let publicKeyData = dataPtr as! Data
            let publicKeyString = publicKeyData.base64EncodedString(options: [])
            return publicKeyString
        }
        else {
            return nil
        }
    }
    
    // Create a new key pair
    func createKeyPair(identifier:String) -> String? {
        var statusCode: OSStatus
        var publicKey: SecKey?
        var privateKey: SecKey?
        
        let KEY_SIZE = 2048
        let PUBLIC_KEY = "iPay.publickey." + identifier
        let PRIVATE_KEY = "iPay.privatekey." + identifier
        
        let publicKeyAttr: [NSObject: NSObject] = [kSecAttrIsPermanent:true as NSObject, kSecAttrApplicationTag:PUBLIC_KEY as NSObject]
        let privateKeyAttr: [NSObject: NSObject] = [kSecAttrIsPermanent:true as NSObject, kSecAttrApplicationTag:PRIVATE_KEY as NSObject]
        
        var keyPairAttr = [NSObject: NSObject]()
        keyPairAttr[kSecAttrKeyType] = kSecAttrKeyTypeRSA
        keyPairAttr[kSecAttrKeySizeInBits] = KEY_SIZE as NSObject?
        keyPairAttr[kSecPublicKeyAttrs] = publicKeyAttr as NSObject?
        keyPairAttr[kSecPrivateKeyAttrs] = privateKeyAttr as NSObject?
        
        statusCode = SecKeyGeneratePair(keyPairAttr as CFDictionary, &publicKey, &privateKey)
        
        if statusCode == noErr && publicKey != nil && privateKey != nil {
            let publicKeyData = SecKeyCopyExternalRepresentation(publicKey!, nil)! as Data
            let publicKeyString = publicKeyData.base64EncodedString(options: [])
            return publicKeyString
        } else {
            return nil
        }
    }
    
    // Encrypted the message by the public key
    func encryptMessage(message:String , identifier:String) -> String {
        //var publicKey: SecKey?
        //publicKey = getPublicKeyRef(identifier: identifier)
        
        var privateKey: SecKey?
        privateKey = getPublicKeyRef(identifier: identifier)
        
        
        let blockSize = SecKeyGetBlockSize(privateKey!)
        var messageEncrypted = [UInt8](repeating: 0, count: blockSize)
        var messageEncryptedSize = blockSize
        
        var status: OSStatus!
        
        status = SecKeyEncrypt(privateKey!, SecPadding.PKCS1, message, message.characters.count, &messageEncrypted, &messageEncryptedSize)
        
        if status == noErr {
            let base64String = messageEncrypted.withUnsafeBufferPointer { buffer -> String in
                let data = NSData(bytes: buffer.baseAddress, length: buffer.count)
                return data.base64EncodedString(options: [])
            }
            return base64String
        }
        else {
            return ""
        }
    }
   
    
    /*
    func decryptMessage(message:String , identifier:String)  {
        var publicKey: SecKey?
        publicKey = getPublicKeyRef(identifier: identifier)
        
        
        let blockSize = SecKeyGetBlockSize(publicKey!)
        
        var status: OSStatus!
        
        var messageDecrypted = [UInt8](repeating: 0, count: blockSize)
        var messageDecryptedSize = blockSize
        
        status = SecKeyDecrypt(publicKey!, SecPadding.PKCS1, &messageDecryptedd, messageDecryptedSize, &messageDecrypted, &messageDecryptedSize)
        
        if status == noErr {
            print(NSString(bytes: &messageDecrypted, length: messageDecryptedSize, encoding: NSUTF8StringEncoding)!)
        }

    }
 */
    
    func getPublicKeyRef(identifier:String) -> SecKey? {
        var dataPtr: AnyObject?
        var statusCode: OSStatus
        let PUBLIC_KEY = "iPay.publickey." + identifier
        
        let query: Dictionary<String, AnyObject> = [
            String(kSecAttrKeyType): kSecAttrKeyTypeRSA,
            String(kSecAttrKeySizeInBits): 2048 as AnyObject,
            String(kSecClass): kSecClassKey,
            String(kSecAttrApplicationTag): PUBLIC_KEY as AnyObject,
            kSecReturnRef as String : kCFBooleanTrue ]
        statusCode = SecItemCopyMatching(query as CFDictionary, &dataPtr)
        if statusCode == noErr {
            let privateKey = dataPtr as! SecKey
            return privateKey
        }
        else {
            return nil
        }
    }
    
    func getPrivateKeyRef(identifier:String) -> SecKey? {
        var dataPtr: AnyObject?
        var statusCode: OSStatus
        let PRIVATE_KEY = "iPay.privatekey." + identifier
        
        let query: Dictionary<String, AnyObject> = [
            String(kSecAttrKeyType): kSecAttrKeyTypeRSA,
            String(kSecAttrKeySizeInBits): 2048 as AnyObject,
            String(kSecClass): kSecClassKey,
            String(kSecAttrApplicationTag): PRIVATE_KEY as AnyObject,
            kSecReturnRef as String : kCFBooleanTrue ]
        
        statusCode = SecItemCopyMatching(query as CFDictionary, &dataPtr)
        
        if statusCode == noErr {
            let privateKey = dataPtr as! SecKey
            return privateKey
        }
        else {
            return nil
        }
    }
    
    /*
    public func rsa_sha1(data plainData)  {
        
        var privateKey: SecKey?
        privateKey = getPrivateKeyRef(identifier: "shan")
        var publicKey: SecKey?
        publicKey = getPublicKeyRef(identifier: "shan")

        
        var digest = NSMutableData(length: Int(CC_SHA1_DIGEST_LENGTH))!
        
        var ptr = digest.bytes.assumingMemoryBound(to: UInt8.self)
        
        // Hash the data
        CC_SHA1(plainData.bytes, CC_LONG(plainData.length), UnsafeMutablePointer<UInt8>(digest.mutableBytes))
        
        // Then sign it
        var signedData = NSMutableData(length: SecKeyGetBlockSize(privateKey!))!
        
        var ptrData = signedData.bytes.assumingMemoryBound(to: UInt8.self)
        
        
        var signedDataLength = signedData.length
        
        let err: OSStatus = SecKeyRawSign(privateKey!,
                                          SecPadding.PKCS1SHA256,
                                          ptr,
                                          digest.length,
                                          ptrData,
                                          &signedDataLength)
        
        if err == errSecSuccess {
            return (signedData: signedData, error: nil)
        }
        
        return (signedData: nil, error: NSError(domain: NSOSStatusErrorDomain, code: Int(err), userInfo: nil))
        
    }
    
    func getSignatureBytes(plainText: String) {
        var result = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH))
        
        var resultLength = result.count
        var privateKey: SecKey?
        privateKey = getPrivateKeyRef(identifier: "shan")
        var publicKey: SecKey?
        publicKey = getPublicKeyRef(identifier: "shan")
        
        
        let SignData = [UInt8](plainText.utf8)
        let SignLength = SignData.count
        
        let status = SecKeyRawSign(privateKey!, SecPadding.PKCS1SHA1, SignData, SignLength, &result, &resultLength)
        let status2 = SecKeyRawVerify(publicKey!, SecPadding.PKCS1SHA1, result, Int(CC_SHA1_DIGEST_LENGTH), &result, resultLength)
    }
    
    
    func signMessage(message:String , identifier:String) -> String? {
        var privateKey: SecKey
        privateKey = getPrivateKeyRef(identifier: identifier)
        
        if let signData = signString(string: message, privateKey: privateKey) {
            return signData
        }
        else{
            return nil
        }
    }
    

    func signString(string: String?, privateKey: SecKey) -> String? {
        let digest = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH))!

     
        var p = UnsafePointer<UInt8>(digest.bytes)
        
        let stringData = string?.data(using: .utf8)
        
        CC_SHA256(stringData?.bytes, CC_LONG(stringData!.length), UnsafeMutablePointer<UInt8>(digest.mutableBytes))
        
        let signedData: NSMutableData = NSMutableData(length: SecKeyGetBlockSize(privateKey))!
        
        var signedDataLength: Int = signedData.length
        
        let err: OSStatus = SecKeyRawSign(
            privateKey,
            SecPadding.PKCS1SHA256,
            UnsafePointer<UInt8>(digest.bytes),
            digest.length,
            UnsafeMutablePointer<UInt8>(signedData.mutableBytes),
            &signedDataLength
        )
        
        switch err {
        case noErr:
            return String(data: signedData, encoding: .utf8)
        default:
            return nil
        }
    } */
    
    
  
}
