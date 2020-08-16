//
//  Crypto.swift
//  iPay
//
//  Created by Thushara Wijekoon on 3/27/18.
//  Copyright © 2018 iPay. All rights reserved.
//

import Foundation
import CoreFoundation
import Security

class Crypto {
    
    var publicKey: SecKey?
    var privateKey: SecKey?
    
    func test() {
        // generating key pair
        let keyPair: (publicKey: SecKey?, privateKey: SecKey?) = generateKeyPair()
        // calculate blocksize
        let blockSize: Int = SecKeyGetBlockSize(keyPair.publicKey!)
        
        // preparing for encryption
        let plainText: String = "sample text to be encrypted and decrypted"
        let plainTextData: [UInt8] = [UInt8](plainText.utf8)
        let plainTextDataLength: Int = plainText.count
        var encryptedData: [UInt8] = [UInt8](repeating: 0, count: Int(blockSize))
        var encryptedDataLength: Int = blockSize
        
        // encrypting
        let encryptOsStatus: OSStatus = SecKeyEncrypt(keyPair.publicKey!, SecPadding.PKCS1, plainTextData, plainTextDataLength, &encryptedData, &encryptedDataLength)
        if encryptOsStatus != noErr {
            print("Encryption Error")
            return;
        }
        
        // preparing for decryption
        var decryptedData: [UInt8] = [UInt8](repeating: 0, count: Int(blockSize))
        var decryptedDataLength: Int = blockSize
        
        // decrypting
        let decryptOsStatus: OSStatus = SecKeyDecrypt(keyPair.privateKey!, SecPadding.PKCS1, encryptedData, encryptedDataLength, &decryptedData, &decryptedDataLength)
        if decryptOsStatus != noErr {
            print("Decryption Error")
            return;
        }
        
        // checking
        let text: NSString = NSString(bytes: &decryptedData, length: decryptedDataLength, encoding: String.Encoding.utf8.rawValue)!
        if text.compare(plainText) == ComparisonResult.orderedSame {
            print("success")
        } else {
            print("failure")
        }
    }
    
    func generateKeyPair () -> (publicKey: SecKey?, privateKey: SecKey?) {
        let parameters: [String: AnyObject] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeySizeInBits as String: 2048 as AnyObject
        ]
        
        let osStatus: OSStatus = SecKeyGeneratePair(parameters as CFDictionary, &publicKey, &privateKey)
        switch osStatus {
        case noErr:
            return (publicKey, privateKey)
        default:
            // TODO: error handling
            return (nil, nil)
        }
    }
    
    func getPublicKey()  ->String? {
        return convertSecKeyToBase64(inputKey: publicKey!)
    }
    
    func convertSecKeyToBase64(inputKey: SecKey) ->String? {
        // First Temp add to keychain
        let tempTag = "de.a-bundle-id.temp"
        let addParameters :[String:AnyObject] = [
            String(kSecClass): kSecClassKey,
            String(kSecAttrApplicationTag): tempTag as AnyObject,
            String(kSecAttrKeyType): kSecAttrKeyTypeRSA,
            String(kSecValueRef): inputKey,
            String(kSecReturnData):kCFBooleanTrue
        ]
        
        var keyPtr: Unmanaged<AnyObject>?
        let result = SecItemAdd(addParameters as CFDictionary, keyPtr as! UnsafeMutablePointer<CFTypeRef?>)
        switch result {
        case noErr:
            let data = keyPtr!.takeRetainedValue() as! NSData
            
            // Remove from Keychain again:
            SecItemDelete(addParameters as CFDictionary)
            let encodingParameter = NSData.Base64EncodingOptions(rawValue: 0)
            return data.base64EncodedString(options: encodingParameter)
            
        case errSecDuplicateItem:
            print("Duplicate Item")
            SecItemDelete(addParameters as CFDictionary)
            return nil
            
        case errSecItemNotFound:
            print("Not found!")
            return nil
            
        default:
            print("Error: \(result)")
            return nil
        }
    }
}
