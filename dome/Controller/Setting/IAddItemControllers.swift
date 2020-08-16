//
//  IAddItemController.swift
//  iPay
//
//  Created by Navoda on 7/30/18.
//  Copyright © 2018 iPay. All rights reserved.
//

import UIKit

class IAddItemControllers: CustomRootViewController, clickPopupButtonDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var addView: UIView!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var tblData: UITableView!
    private var cellTbl : String = "cellTbl"
    
    var dataDic = [IAdShowData]()
    var insideData : [String: Any] = [String: Any]()

    var addItem : Advetisment!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView.layer.cornerRadius = 15
        addView.layer.borderWidth = 3
        addView.layer.borderColor = UIColor(hexString: "D2DFEA").cgColor
        
        imgView.cornerRadius = 15
        tblData.dataSource = self
        tblData.delegate = self
        tblData.register(tblCell.self, forCellReuseIdentifier: cellTbl)

        title = getLocalizedString(key: "iads")
        if addItem != nil{
            getAdvertisement()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellTbl, for: indexPath) as! tblCell
        let temp :IAdShowData = dataDic[indexPath.row]
        cell.lblKey.text = temp.key
        cell.lblValue.text = temp.value
        cell.lblDot.text = ":"

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @IBAction func onTapback(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func clickButton(callBackIndex: Int) {
        
    }
    
    func daySuffix(from dayOfMonth: Int) -> String {
        switch dayOfMonth {
        case 1, 21, 31: return "st"
        case 2, 22: return "nd"
        case 3, 23: return "rd"
        default: return "th"
        }
    }
    
    func setDateFormat(rDate : String) -> String{
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let date = dateFormatter.date(from: rDate)
        let day = calendar.component(.day, from: date!)
        let dateComponents = calendar.dateComponents([.day, .month, .year], from: date!)
        let monthName = calendar.monthSymbols[dateComponents.month! - 1]
        let yearr : String = String(describing: dateComponents.year!)
        
         return "\(String(format: "%02d", day))\(daySuffix(from: day))" + " " + monthName.substring(to: monthName.index(monthName.startIndex, offsetBy: 3)) + " \(yearr)  "
    }
    
    func getAdvertisement() {
        self.rootAuthManager?.getCustomActivityIndicator().start(view: self.view)
        
        let sslParam : SSLRequestParams = SSLRequestParams()
        sslParam.accessToken = self.rootAuthManager?.getAccessToken()
        sslParam.httpMethod = HttpMethod.GET
        sslParam.reqType  = RequestType.NORMAL
        sslParam.url = self.rootAuthManager?.getSettings().getSingleAdvertisment(id: self.rootAuthManager!.getCustomerId(), advertisementId: addItem.id!)
        
        sslParam.callbackFunction = { (responseObj ) in
            self.rootAuthManager?.getCustomActivityIndicator().stop()
            if responseObj.responseCode == 200 {
                if let ref : IpayResponseObject = IpayResponseObject(json: responseObj.responseObject){
                    if let singleAdd : Advetisment = Advetisment(json: ref.responseObject!) {
                        
                        self.lblTitle.text = singleAdd.advertisementTitle
                        self.lblDescription.text = singleAdd.notificationText
//                        self.lblPrice.text = "Rs " + singleAdd.price!
//                        self.lblLocation.text = singleAdd.location
//                        self.lblAt.text = singleAdd.merchantName
                        
//                        self.lblValidity.text = self.setDateFormat(rDate: singleAdd.createdDate!) + "to " + self.setDateFormat(rDate: singleAdd.expiryDate!)

                        let img : AdvertismentImage = AdvertismentImage(json: (singleAdd.images?.first)!)!
                        let addImage = img.image
                        if addImage?.count != 0 {
                            let data = NSData(base64Encoded: addImage!, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
                            self.imgView.image = UIImage(data: data! as Data)!
                        }else {
                                //            self.imgLogoView.image = UIImage(named: "merchants")
                        }
                        
                        self.dataDic.append(IAdShowData(key: "validity", value: self.setDateFormat(rDate: singleAdd.createdDate!) + "to " + self.setDateFormat(rDate: singleAdd.expiryDate!)))
//                        self.insideData["validity"] = self.setDateFormat(rDate: singleAdd.createdDate!) + "to " + self.setDateFormat(rDate: singleAdd.expiryDate!)
                        self.dataDic.append(IAdShowData(key: "at", value: singleAdd.merchantName!))

//                        self.dataDic.add(self.insideData["validity"]!)
//                        self.dataDic.add(self.insideData["at"]!)

                        if singleAdd.price != "0.00"{
                            let price : String = "Rs " + singleAdd.price!
                            self.dataDic.append(IAdShowData(key: "price", value: price))

                        }
                        if singleAdd.location != ""{
                            self.dataDic.append(IAdShowData(key: "location", value: singleAdd.location!))

                        }
                        if singleAdd.quantity != "0"{
                            self.dataDic.append(IAdShowData(key: "quantity", value: singleAdd.quantity!))
                        }
                        
                        self.tblData.reloadData()
                        
//                        if singleAdd.location != ""{
//                            self.lblLocation.text = singleAdd.location
//                        }
//                        else{
//                            self.lblLocation.isHidden = true
//                            self.lblLo.isHidden = true
//                            self.lblLodot.isHidden = true
//                        }
//
//                        if singleAdd.quantity != ""{
//                            self.lblQuantity.text = singleAdd.quantity
//                        }
//                        else{
//                            self.lblQu.isHidden = true
//                            self.lblQuantity.isHidden = true
//                            self.lblDot.isHidden = true
//                        }
                    }
                }
                else{
                    let err : IpayError =  IpayError(json: responseObj.responseObject)!
                    self.rootAuthManager?.showErrorPopup(errorTitle: getLocalizedString(key: "error"), errorMessage: err.errorMessage!,btnText: getLocalizedString(key: "close"), isError : true, clickDelegate : self, callbackIndex : 0 )
                }
            }
            else{
                let err : IpayError =  IpayError(json: responseObj.responseObject)!
                self.rootAuthManager?.showErrorPopup(errorTitle: getLocalizedString(key: "error"), errorMessage: err.errorMessage!,btnText: getLocalizedString(key: "close"), isError : true, clickDelegate : self, callbackIndex : 0 )
            }
        }
        self.rootAuthManager?.comManager?.invokeRestService(sslReqParams: sslParam, authManager: self.rootAuthManager!)
    }
    
}

class tblCell : UITableViewCell{
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(lblKey)
        addSubview(lblValue)
        addSubview(lblDot)

        backgroundColor = UIColor.white
        lblKey.frame = CGRect(x: 0, y: 10, width: 80, height: 40)
        lblDot.frame = CGRect(x: 85, y: 10, width: 10, height: 40)
        lblValue.frame = CGRect(x: 100, y: 10, width: frame.width - 110, height: 40)


    }
    
    let lblKey : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 2
        return lbl
    }()
    
    let lblValue : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 2
        return lbl
    }()
    
    let lblDot : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
}
