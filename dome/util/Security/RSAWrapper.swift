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

class RSAWrapper {
    
    private var publicKey : SecKey?
    private var privateKey : SecKey?
    
    private let publicKeyTag = "iPay.publickey."
    private let privateKeyTag = "iPay.privatekey."
    
    private var keyGenerated = false
    
    let keySize = 1024
    
    // Init
    init(identifier: String)  {
        if (!isPublicKeyFound(identifier: identifier)){
            if (generateKeyPair(identifier: identifier)) {
                print("KeyPair generated for " + identifier)
                keyGenerated = true
            }
            else {
                print("KeyPair not generated for " + identifier)
                keyGenerated = false
            }
        }
        else {
            print("KeyPair found for " + identifier)
            keyGenerated = true
            self.privateKey = getPrivateKeyRef(identifier: identifier)
            self.publicKey = getPublicKeyRef(identifier: identifier)
        }
    }

    
    // Check if public key found in keychain
    private func isPublicKeyFound(identifier:String) -> Bool {
        var dataPtr: AnyObject?
        var statusCode: OSStatus
        let publicTag = publicKeyTag + identifier
        let query: [NSString: Any] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: publicTag,
            kSecReturnData: NSNumber(value: true)
        ]
        statusCode = SecItemCopyMatching(query as CFDictionary, &dataPtr)
        if statusCode == noErr {
            return true
        }
        else {
            return false
        }
    }
    
    private func generateKeyPair(identifier: String) -> Bool {
        
        self.publicKey = nil
        self.privateKey = nil
        
        let publicTag = publicKeyTag + identifier
        let privateTag = privateKeyTag + identifier
        
        let publicKeyParameters: [NSString: AnyObject] = [
            kSecAttrIsPermanent: true as AnyObject,
            kSecAttrApplicationTag: publicTag as AnyObject
        ]
        let privateKeyParameters: [NSString: AnyObject] = [
            kSecAttrIsPermanent: true as AnyObject,
            kSecAttrApplicationTag: privateTag as AnyObject
        ]
        let parameters: [String: AnyObject] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeySizeInBits as String: keySize as AnyObject,
            kSecPrivateKeyAttrs as String: privateKeyParameters as AnyObject,
            kSecPublicKeyAttrs as String: publicKeyParameters as AnyObject
        ];
        
        let status : OSStatus = SecKeyGeneratePair(parameters as CFDictionary, &(self.publicKey), &(self.privateKey))
        
        return (status == errSecSuccess && self.publicKey != nil && self.privateKey != nil)
    }
    
    private func getPublicKeyRef(identifier:String) -> SecKey? {
        var dataPtr: AnyObject?
        var statusCode: OSStatus
        let publicTag = publicKeyTag + identifier
        
        let query: Dictionary<String, AnyObject> = [
            String(kSecAttrKeyType): kSecAttrKeyTypeRSA,
            String(kSecAttrKeySizeInBits): keySize as AnyObject,
            String(kSecClass): kSecClassKey,
            String(kSecAttrApplicationTag): publicTag as AnyObject,
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
    
    private func getPrivateKeyRef(identifier:String) -> SecKey? {
        var dataPtr: AnyObject?
        var statusCode: OSStatus
        
        let privateTag = privateKeyTag + identifier
        
        let query: Dictionary<String, AnyObject> = [
            String(kSecAttrKeyType): kSecAttrKeyTypeRSA,
            String(kSecAttrKeySizeInBits): keySize as AnyObject,
            String(kSecClass): kSecClassKey,
            String(kSecAttrApplicationTag): privateTag as AnyObject,
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
    
    private func getPublicKey() -> SecKey? {
        return self.publicKey
    }
    
    private func getPrivateKey() -> SecKey? {
        return self.privateKey
    }
    
    // Public function starts here
    
    func encrypt(text: String) -> [UInt8] {
        let plainBuffer = [UInt8](text.utf8)
        var cipherBufferSize : Int = Int(SecKeyGetBlockSize((self.publicKey)!))
        var cipherBuffer = [UInt8](repeating:0, count:Int(cipherBufferSize))
        
        let status = SecKeyEncrypt((self.publicKey)!, SecPadding.PKCS1, plainBuffer, plainBuffer.count, &cipherBuffer, &cipherBufferSize)
        if (status != errSecSuccess) {
            print("Failed Encryption")
        }
        return cipherBuffer
    }
    
    
    func decprypt(encrpted: [UInt8]) -> String? {
        var plaintextBufferSize = Int(SecKeyGetBlockSize((self.privateKey)!))
        var plaintextBuffer = [UInt8](repeating:0, count:Int(plaintextBufferSize))
        
        let status = SecKeyDecrypt((self.privateKey)!, SecPadding.PKCS1, encrpted, plaintextBufferSize, &plaintextBuffer, &plaintextBufferSize)
        
        if (status != errSecSuccess) {
            print("Failed Decrypt")
            return nil
        }
        return NSString(bytes: &plaintextBuffer, length: plaintextBufferSize, encoding: String.Encoding.utf8.rawValue)! as String
    }
    
    func encryptBase64(text: String) -> String {
        let plainBuffer = [UInt8](text.utf8)
        var cipherBufferSize : Int = Int(SecKeyGetBlockSize((self.publicKey)!))
        var cipherBuffer = [UInt8](repeating:0, count:Int(cipherBufferSize))
        
        let status = SecKeyEncrypt((self.publicKey)!, SecPadding.PKCS1, plainBuffer, plainBuffer.count, &cipherBuffer, &cipherBufferSize)
        if (status != errSecSuccess) {
            print("Failed Encryption")
        }
        
        let mudata = NSData(bytes: &cipherBuffer, length: cipherBufferSize)
        return mudata.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
    }
    
    func decpryptBase64(encrpted: String) -> String? {
        
        let data : NSData = NSData(base64Encoded: encrpted, options: .ignoreUnknownCharacters)!
        let count = data.length / MemoryLayout<UInt8>.size
        var array = [UInt8](repeating: 0, count: count)
        data.getBytes(&array, length:count * MemoryLayout<UInt8>.size)
        
        var plaintextBufferSize = Int(SecKeyGetBlockSize((self.privateKey)!))
        var plaintextBuffer = [UInt8](repeating:0, count:Int(plaintextBufferSize))
        
        let status = SecKeyDecrypt((self.privateKey)!, SecPadding.PKCS1, array, plaintextBufferSize, &plaintextBuffer, &plaintextBufferSize)
        
        if (status != errSecSuccess) {
            print("Failed Decrypt")
            return nil
        }
        return NSString(bytes: &plaintextBuffer, length: plaintextBufferSize, encoding: String.Encoding.utf8.rawValue)! as String
    }
    
    func getPublicKeyBase64() -> String {
        let publicKeyData = SecKeyCopyExternalRepresentation(publicKey!, nil)! as Data
        let publicKeyString = publicKeyData.base64EncodedString(options: [])
        return publicKeyString
    }
    
    func isKeyGenerated() -> Bool {
        return keyGenerated
    }
   // Public function ends here
}
