//
//  Settings.swift
//  iPay
//
//  Created by Chandana Pathirage on 3/21/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import UIKit

public class Settings: NSObject {
    
    private let API_SERVER_URL: String = Settings.getServerIp() + "/apis/v1/" // /api.ipay/v1/
//    private let API_SERVER_URL_WO: String = Settings.getServerIp() + "/apis-wo/v2/" // /api.ipay-wo/v1/
    private let KEY_LANG: String = "lang"
    private let KEY_CUS_ID: String = "cus_id"
    private let KEY_CUS_UP_ID: String = "cus_up_id"
    private let KEY_CUS_ACCOUNTS: String = "cus_accounts"
    private let KEY_PIN_CODE: String = "pin_code"
    private let KEY_USERNAME: String = "username"
    private let KEY_FAV_MERCHANTS: String = "fav_merchants"
    private let KEY_DEVICE_ID: String = "device_id"
    private let KEY_PUSH_TOKEN: String = "push_token"
    private let KEY_HAS_ACCOUNTS: String = "has_accounts"
    
    private let KEY_CLIENT_ID: String = "client_id"
    private let KEY_CLIENT_SECRET: String = "client_secret"
    public static let KEY_GRANT_TYPE: String = "grant_type"
    
    private let KEY_RSA_PUBLIC_KEY: String = "RSA_PUBLIC_KEY"
    
    public static let KEY_ACCESS_TOKEN: String = "access_token"
    public static let KEY_REFRESH_TOKEN: String = "refresh_token";
    public static let KEY_TEMP_ACCESS_TOKEN: String = "temp_access_token";
    
    public static let KEY_TRANS_FINGERPRINT: String = "key_trans_fingerprint";
    public static let KEY_TRANS_PIN: String = "key_trans_pin";
    public static let KEY_TRANS_PATTERN: String = "key_trans_pattern";
    public static let KEY_TRANS_SWIPE: String = "key_trans_swipe";
    public static let KEY_APP_FINGERPRINT: String = "key_app_fingerprint";
    public static let KEY_APP_PIN: String = "key_app_pin";
    
    public func getCustomerRegisterURL() -> String {
        return API_SERVER_URL + "customer/register"
    }
    
    public func getCustomerActivateURL() -> String {
        return API_SERVER_URL + "customer/activate"
    }
    
    public func getCustomerResendVerificationURL() -> String {
        return API_SERVER_URL + "customer/resendVerification"
    }
    
    public func getCustomerLoginURL() -> String {
        return API_SERVER_URL + "ipay-login"
    }
    
    public func getAssociateAccountURL() -> String {
        return API_SERVER_URL + "customer/associate"
    }
    
    public func getVerifyAccounURL() -> String {
        return API_SERVER_URL + "customer/account/verify"
    }
    
    public func getIdsURL() -> String {
        return Settings.getServerIp() + "/apis/token"
    }
    
    public func getIdsLogoutUrl() -> String {
        return Settings.getServerIp() + "/apis/revoke"
    }
    
    public func getCustomerDetailUrl() -> String {
        return API_SERVER_URL + "customer"
    }
    
    public func getCustomerAccountExpTime() -> String {
        return API_SERVER_URL + "customer/account/expiarytime"
    }
    
    public func getDeviceRegisterUrl(id: Int) -> String{
        return API_SERVER_URL + "customer/\(id)/devices"
    }
    
    public func getPaymentUrl2(deviceID: String) -> String {
        return API_SERVER_URL + deviceID + "/makePayment2"
    }
    
    public func getPaymentUrl(deviceID: String) -> String {
        return API_SERVER_URL + deviceID + "/makePayment"
    }
    
    public func getUtilityPaymentUrl(deviceID: String) -> String {
        return API_SERVER_URL + deviceID + "/utilityPayments"
    }
    
    public func getFundTransferPaymentUrl(deviceID: String) -> String {
        return API_SERVER_URL + deviceID + "/fund-transfer"
    }
    
    public func getInstrumentPaymentUrl(deviceID: String) -> String {
        return API_SERVER_URL + deviceID + "/instrumentPay"
    }
    
    public func getCommisionUrl(deviceID: String) -> String {
        return API_SERVER_URL + deviceID + "/makePayment/fees"
    }
    
    public func getUtilityCommissionUrl(deviceID: String) -> String {
        return API_SERVER_URL + deviceID + "/utilityPayments/fees"
    }
    
    public func getFundTransferCommissionUrl(deviceID: String) -> String {
        return API_SERVER_URL + deviceID + "/fund-transfer/fees"
    }
    
    public func getInstrumentPaymentCommissionUrl(deviceID: String) -> String {
        return API_SERVER_URL + deviceID + "/instrumentPay/fees"
    }
    
    public func getBankUrl() -> String {
        return API_SERVER_URL + "customer/banks"
    }
    
    public func getCeftBankUrl() -> String {
        return API_SERVER_URL + "customer/banks?action=ftrBanks"
    }
    
    public func getBankDetailsById(cusID : String , bId : String) -> String {
        return API_SERVER_URL + "customer/\(cusID)/bank/\(bId)"
    }
    
    public func getProfileQrCode() -> String {
        return API_SERVER_URL + "qrcode/generate?"
    }
    
    public func getMerchantsUrl() -> String {
        return API_SERVER_URL + "merchants"
    }
    
    public func getMerchantsSearchUrl(query: String) -> String {
        return API_SERVER_URL + "merchants?action=query&query=\(query)"
    }
    
    public func getMerchantsLocationWiseSearchUrl(query: String, lat : Double, lon : Double, searchRangeInKm : Float) -> String {
        return API_SERVER_URL + "merchants?action=query&query=\(query)&locationEnabled=Y&lat=\(lat)&lng=\(lon)&searchRangeInKm=\(searchRangeInKm)"
    }
    
    public func getMerchantsDetails(id: String) -> String {
        return API_SERVER_URL + "merchants/\(id)"
    }
    
    public func getUtilityMerchantsDataById(id: String, um_id : String) -> String {
        return API_SERVER_URL + "customer/\(id)/utilityMerchants/\(um_id)"
    }
    
    public func getMerchantsMapLocations(id: String) -> String {
        return API_SERVER_URL + "customer/\(id)/merchants/visibleRegionLocations/"
    }
    
    public func getAdvertismentList(id: String) -> String {
        return API_SERVER_URL + "customer/\(id)/advertisements/"
    }
    
    public func getSingleAdvertisment(id: String, advertisementId : Int) -> String {
        return API_SERVER_URL + "customer/\(id)/advertisements/\(advertisementId)/"
    }
    
    public func removeBankAccount(id: String, bankId : Int) -> String {
        return API_SERVER_URL + "customer/\(id)/bankAccounts/\(bankId)/"
    }
    
    public func getUtilityMerchantsSearchUrl(id: String) -> String {
        return API_SERVER_URL + "customer/\(id)/utilityMerchants"
    }
    
    public func getUtilityMerchantsGroupUrl(id: String) -> String {
        return API_SERVER_URL + "customer/\(id)/utility/utilityGrouping"
    }
    
    public func getUtilityMerchantsPackegers(id: String, mid: Int) -> String {
        return API_SERVER_URL + "customer/\(id)/getUtilityPackages/\(mid)"
    }
    
    public func getMerchantBranches(merchantId: Int) -> String {
        return API_SERVER_URL + "merchants/\(merchantId)/branches"
    }
    
    public func getUtilityProviderLogo(cusId : String, providerId : Int) -> String {
        return API_SERVER_URL + "customer/\(cusId)/utilityProviders/\(providerId)"
    }
    
    public func getRepeatPaymentFees(did: String ) -> String {
        return API_SERVER_URL + "\(did)/repeatPayments/fees"
    }
    
    public func getRepeatPayment(did: String ) -> String {
        return API_SERVER_URL + "\(did)/repeatPayments"
    }
    
    public func getPaymentPopupButtonsAvailability(cusId : String) -> String {
           return API_SERVER_URL + "customer/\(cusId)/favourites/exist"
       }
    
    public func getDeleteNotificationByIdUrl(cusId: String, nId : Int) -> String {
        return API_SERVER_URL + "customer/\(cusId)/paymentSchedulerByCustomer/\(nId)"
    }
    
    public func getAvailableTransactionlimit(cusId : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/availableTransactionLimit"
    }
    
    public func getPaymentInfoUrl(refNo: String) -> String {
        return API_SERVER_URL + "paymentInfo?instrumentRefNo=" + refNo
    }
    
    public func getAcknowledgementUrl(deviceId : String) -> String {
        return API_SERVER_URL + "\(deviceId)/instrumentPay/acknowledgement"
    }
    
    public func getAcqBankUrl() -> String{
        return API_SERVER_URL + "customer/banks?action=acq"
    }
    
    public func getMerchantBankAccountUrl(merchantId: Int, branchId: Int) -> String {
        return API_SERVER_URL + "merchants/\(merchantId)/branches/\(branchId)/bankAccounts?action=defaultAccount"
    }
    
    public func getMakeDefaultBankAccountUrl(customerId: String) -> String {
        return API_SERVER_URL + "customer/\(customerId)/makeDefaultBankAccount"
    }
    
    public func getLockStatusUrl(userName: String) -> String {
        return API_SERVER_URL + "customer?action=status&username=\(userName)"
    }
    
    public func getUserBlockingUrl() -> String {
        return API_SERVER_URL + "customer/blockUser"
    }
    
    public func getCurrentVersionURL() -> String {
        return Settings.getServerIp() + "/apis/versions/v1/versions?applicationType=CUSTOMER_IOS"
    }
    
    public func getAllSecQuestionsUrl() -> String {
        return API_SERVER_URL + "customer/forgotpassword/allchallenges"
    }
    
    public func getUserSecQuestionsUrl(username :String) -> String {
        return API_SERVER_URL + "customer/forgotpassword/challenges?username=\(username)"
    }
    
    public func getMobileAndEmail(username :String) -> String {
        return API_SERVER_URL + "customer/forgotpassword/getMobileNumberAndEmailByUserName/\(username)"
    }
    
    public func getVerificationCode() -> String {
        return API_SERVER_URL + "customer/forgotpassword/initiateNewPassword"
    }
    
    public func getVerificationCodeResend() -> String {
        return API_SERVER_URL + "customer/forgotpassword/initiateNewPasswordResend"
    }
    
    public func getOTPverifyUrl() -> String {
        return API_SERVER_URL + "customer/forgotpassword/otpVerification"
    }
    
    public func getSetSecQueAnswersUrl(cusId :String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/challenges"
    }
    
    public func getUserVerifySecQueAnswersUrl() -> String {
        return API_SERVER_URL + "customer/forgotpassword/challenges/verify"
    }
    
    public func getUserUpdateForgotPassword() -> String {
        return API_SERVER_URL + "customer/forgotpassword/update"
    }
    
    public func  getLcChallengeUrl(cusId : String, deviceId : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/\(deviceId)/payment_challenges"
    }
    
    public func  getLcChallengeForBankUrl(cusId : String, deviceId : String, bankId : Int) -> String {
        return API_SERVER_URL + "customer/\(cusId)/\(deviceId)/payment_challenges/banks/\(bankId)"
    }
    
    public func  getLcSaveMandateUrl(cusId : String, deviceId : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/\(deviceId)/save_mandate"
    }
    
    public func getContactListCheckUrl(cusId : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/contactslist"
    }
    
    public func getFavoriteUrl(cusId : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/favourites"
    }
    
    public func getFundTransferFavouriteUrl(cusId : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/fundtransfer/favourites"
    }
    
    public func getUtilityFavouriteUrl(cusId : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/utility/favourites"
    }
    
    public func getMerchantFavouriteUrl(cusId : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/merchants/favourites"
    }
    
    public func getMerchantAttributesUrl(id: String) -> String {
        return API_SERVER_URL + "customer/\(id)/merchants/attributes"
    }
    
    public func getTopAddsUrl() -> String {
        return API_SERVER_URL + "utilities/promotions"
    }
    
    public func getMiniStatement(cusId : String, accId : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/miniTransactions?ipayCustomerBankAccountId=\(accId)"
    }
    
    public func getbankAccountsWithBalance(cusId : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/bankAccountsWithBalance"
    }
    
    public func getCreateStandingOrderUrl(cusId : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/standingOrders"
    }
    
    public func getAllStandingOrderUrl(cusId : String, payer : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/standingOrders?payer=\(payer)"
    }
    
    public func getSingleStandingOrderUrl(cusId : String, ref : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/standingOrders/\(ref)"
    }
    
    public func getUpdateStandingOrderUrl(cusId : String, ref : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/standingOrders/\(ref)"
    }
    
    public func getDeleteStandingOrderUrl(cusId : String, ref : String, payer : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/standingOrders/\(ref)?payer=\(payer)"
    }
    
    public func getFixedDepositTermsURL(cusId : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/fixedDeposit/terms"
    }
    
    public func getCreateFDUrl(cusId : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/fixedDeposit"
    }
    
    public func getFtTimeChekUrl(deviceId : String) -> String {
        return API_SERVER_URL + "\(deviceId)/externalTxnPossibleHours"
    }
    
    public func getRegisterKycUrl(cid : String) -> String {
        return API_SERVER_URL + "customer/\(cid)/kyc"
    }
    
    public func getUtilityNames(cid: String ) -> String {
        return API_SERVER_URL + "customer/\(cid)/utilityMerchants/names"
    }
    
    public func getFavNames(cid: String ) -> String {
        return API_SERVER_URL + "customer/\(cid)/favourites/nicknames"
    }
    
    public func getRequestMoneyDeclinedUrl(cusId : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/paymentRequestResponce"
    }
    
    public func getNotifiationUrl(id: String) -> String {
        return API_SERVER_URL + "customer/\(id)/notifications"
    }
    
    public func getMarkAsRead(cid: String , nid : String) -> String {
        return API_SERVER_URL + "customer/\(cid)/notifications/\(nid)"
    }
    
    public func getDynamic(id: String) -> String {
        return API_SERVER_URL + "customer/\(id)/dynamicIcon"
    }
    
    public func getNotificationCount(id: String) -> String {
        return API_SERVER_URL + "customer/\(id)/notifications/new"
    }
    
    public func getCustomerSpending(id: String, currency : String) -> String {
        return API_SERVER_URL + "customer/\(id)/totalSpending/\(currency)"
    }
    
    public func getRequestLimitsUrl(cusId: String, txnType : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/paymentRequest/limits?currencyType=\(txnType)"
    }
    
    public func getRequestMoneyUrl(cusId : String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/paymentRequestByContact"
    }
    
    public func getCreateSchedule(cusId: String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/paymentSchedulerByCustomer"
    }
    
    public func getDeleteScheduleByIdUrl(cusId: String, sId : Int) -> String {
        return API_SERVER_URL + "customer/\(cusId)/paymentScheduler/\(sId)"
    }
    
    public func getScheduleList(cusId: String) -> String {
        return API_SERVER_URL + "customer/\(cusId)/paymentScheduleHistory"
    }
    
    public static func getServerIp() -> String {
        var serverIp : String = ""
        #if ENV_DEV
        serverIp = "https://developer.ipay.com.kh" // development
        #endif
        
        #if ENV_SANDBOX
        serverIp = "https://sandbox.ipay.lk" // sandbox
        #endif
        
        #if ENV_STAGIN
        serverIp = "https://staging.ipay.lk" // staging, use sandbox clientid / secret
        #endif
        
        #if ENV_LIVE
        serverIp = "https://ipay.com.kh" // live
        #endif
        return serverIp
    }
    
    // ClientID
    public func getClientId() -> String {
        var clientId : String = ""
        #if ENV_DEV
        clientId =  KEY_CLIENT_ID + "=xlGw25p71UxtVTvQ4Sq8deOTxDga" //dev
        #endif
        
        #if ENV_SANDBOX
        clientId =  KEY_CLIENT_ID + "=xlGw25p71UxtVTvQ4Sq8deOTxDga" //sandbox
        #endif
        
        #if ENV_STAGIN
        clientId = KEY_CLIENT_ID + "=xlGw25p71UxtVTvQ4Sq8deOTxDga" //sandbox
        #endif
        
        #if ENV_LIVE
        clientId =  KEY_CLIENT_ID + "=DqhHleZHrHXV1fK2GwvfYfG98LQa" //live
        #endif
        return clientId
    }
    
    // ClientSecret
    public func getClientSecret() -> String {
        var clientSecret : String = ""
        #if ENV_DEV
        clientSecret =  KEY_CLIENT_SECRET + "=SWfCLCwBE0ajp0jrH69AiIoJJBoa" // dev
        #endif
        
        #if ENV_SANDBOX
        clientSecret = KEY_CLIENT_SECRET + "=SWfCLCwBE0ajp0jrH69AiIoJJBoa" // sandbox
        #endif
        
        #if ENV_STAGIN
        clientSecret = KEY_CLIENT_SECRET + "=SWfCLCwBE0ajp0jrH69AiIoJJBoa" // sandbox
        #endif
        
        #if ENV_LIVE
        clientSecret =  KEY_CLIENT_SECRET + "=1b47gEKrZvOUgScNVOMRCJ7NsWoa" // live
        #endif
        return clientSecret
    }
    
    public static func getMinioServerIp() -> String {
        var serverIp : String = ""
        #if ENV_DEV
        serverIp = "https://objects-developer.ipay.com.kh" // development
        #endif
        
        #if ENV_SANDBOX
        serverIp = "https://objects-sandbox.ipay.lk" // sandbox
        #endif
        
        #if ENV_STAGIN
        serverIp = "https://objects-staging.ipay.lk" // staging, use sandbox clientid / secret
        #endif
        
        #if ENV_LIVE
        serverIp = "https://objects.ipay.com.kh" // live
        #endif
        return serverIp
    }
    
    // getMinio id
    public static func getMinioAccessKey() -> String {
        
        var minioKey : String = ""
        #if ENV_DEV
        minioKey =  "2G0PPXZQG885BTGE8ME2" //dev
        #endif
        
        #if ENV_SANDBOX
        minioKey = "X0XRWMXUQXCIURKECAXX" //sandbox
        #endif
        
        #if ENV_STAGIN
        minioKey = "2G0PPXZQG885BTGE8ME2" //sandbox
        #endif
        
        #if ENV_LIVE
        minioKey =  "z$yv7|ljP9|O90O" //live
        #endif
        return minioKey
    }
    
    // getMinio secret
    public static func getMinioSecretKey() -> String {
        var minioSecret : String = ""
        #if ENV_DEV
        minioSecret =  "+dqppCg9u4hTRT07VLUMYZQ8m5ZC+EV034kzOAfM" // dev
        #endif
        
        #if ENV_SANDBOX
        minioSecret = "jM0UFWSlt9/56rbr9ghlJNTQGMBx165DpcesIOwd+" // sandbox
        #endif
        
        #if ENV_STAGIN
        minioSecret = "+dqppCg9u4hTRT07VLUMYZQ8m5ZC+EV034kzOAfM" // sandbox
        #endif
        
        #if ENV_LIVE
        minioSecret =  "vqSsE5ScUkbdpRWaJFRePJCP3D7T9gtn" // live
        #endif
        return minioSecret
    }
}

