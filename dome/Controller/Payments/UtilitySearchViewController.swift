//
//  UtilitySearchViewController.swift
//  iPay
//
//  Created by Thushara Wijekoon on 12/7/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import UIKit

class UtilitySearchViewController: CustomRootViewController , UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, clickPopupButtonDelegate{
    
    var merchants = [UtilityMerchant]()
    var searchMerchantsArray = [UtilityMerchant]()
    var searching:Bool = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = getLocalizedString(key: "utility_merchants")
         searchMerchants()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchMerchantsArray = merchants.filter({ (merchent) -> Bool in
            let tem = merchent
            let name = tem.utilityMerchantName! as NSString
            let range = name.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        
        if (searchMerchantsArray.count == 0){
            searching = false
        } else {
            searching = true
        }
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching == true {
            return searchMerchantsArray.count
        } else {
            return merchants.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchPayCollectionViewCell", for: indexPath) as! SearchPayCollectionViewCell
        let logo : String
        if searching == true {
            logo = searchMerchantsArray[indexPath.row].logo!
            cell.searchPayLabel.text = searchMerchantsArray[indexPath.row].utilityMerchantName
        }else{
            logo = merchants[indexPath.row].logo!
            cell.searchPayLabel.text = merchants[indexPath.row].utilityMerchantName
        }
        if logo.count != 0 {
            let data = NSData(base64Encoded: logo, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
            cell.searchPayUIImage.image = UIImage(data: data! as Data)!
        }else {
           cell.searchPayUIImage.image =  UIImage()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Select \(indexPath.row)")
        var accountView: UIStoryboard!
        accountView = UIStoryboard(name: "Payment", bundle: nil)
        
        let viewcontroller : PaymentViewController = accountView.instantiateViewController(withIdentifier: "Payment") as! PaymentViewController
        if searching == true {
            viewcontroller.utilityMerchant = searchMerchantsArray[indexPath.row]
        }else{
            viewcontroller.utilityMerchant = merchants[indexPath.row]
        }
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    func searchMerchants() -> Void {
        if merchants.count > 0 {
            merchants.removeAll()
        }
        
        self.rootAuthManager?.getCustomActivityIndicator().start(view: self.view)
        
        let sslParam : SSLRequestParams = SSLRequestParams()
        sslParam.accessToken = self.rootAuthManager?.getAccessToken()
        sslParam.httpMethod = HttpMethod.GET
        sslParam.reqType  = RequestType.NORMAL
        sslParam.url = self.rootAuthManager?.getSettings().getUtilityMerchantsSearchUrl(id: self.rootAuthManager!.getCustomerId())
        
        sslParam.callbackFunction = { (responseObj ) in
            self.rootAuthManager?.getCustomActivityIndicator().stop()
            if responseObj.statusCodde == 200 {
                if let ref : IpayResponseArray = IpayResponseArray(json: responseObj.response){
                    for anItem in ref.responseObject! {
                        let merchantAccount :UtilityMerchant = UtilityMerchant(json: anItem)!
                        self.merchants.append(merchantAccount)
                    }
                    self.collectionView.reloadData()
                } else {
                    let ref2 : IpayResponseObject = IpayResponseObject(json: responseObj.response)!
                    let err : IpayError = IpayError(json: ref2.responseObject!)!
                    var errmessage : String = "Merchants loading error."
                    if err.errorMessage != nil {
                        errmessage = err.errorMessage!
                    }
                    self.rootAuthManager?.showErrorPopup(errorTitle: getLocalizedString(key: "error"), errorMessage: errmessage,btnText: getLocalizedString(key: "close"), isError : true, clickDelegate : self, callbackIndex : 0 )
                }
            }else{
                let ref : IpayResponseObject = IpayResponseObject(json: responseObj.response)!
                let err : IpayError =  IpayError(json: ref.responseObject!)!
                self.rootAuthManager?.showErrorPopup(errorTitle: getLocalizedString(key: "error"), errorMessage: err.errorMessage!,btnText: getLocalizedString(key: "close"), isError : true, clickDelegate : self, callbackIndex : 0 )
            }
        }
        self.rootAuthManager?.comManager?.invokeRestService(sslReqParams: sslParam, authManager: self.rootAuthManager!)
    }
    
    func clickButton(callBackIndex: Int) {}
}
