//
//  CurrencyView.swift
//  iPayMerchant
//
//  Created by Navoda on 4/6/20.
//  Copyright © 2020 iPay (Pvt) Ltd. All rights reserved.
//

import UIKit
import Foundation

protocol CurrencyViewDelegate  {
    func selectedCurrency(currency : CurrencyType , callBack : Int)
    func setCurrency(setCurrencyvalue : CurrencyType)
}

extension CurrencyViewDelegate{
    func setCurrency(setCurrencyvalue : CurrencyType){}
}

//@IBDesignable
class CurrencyView: UIView {

    //fullheight = 90 without title 60
    
    @IBOutlet var viewbackground: UIView!
    @IBOutlet private var btnTxn: [UIButton]!
    @IBOutlet private weak var lblTitle: IpayLabel!
    var callBack : Int = 0
    var currencyDelegate : CurrencyViewDelegate!
    private let nibName = "CurrencyView"
    
    var defaultBtnColor : UIColor = UIColor(hexString: "D6D6D6")
    var defaultBtnTextColor : UIColor = UIColor.darkGray
    var selectedBtnColor : UIColor = UIColor(hexString: "31BA74")
    var disableBtnColor : UIColor = UIColor(hexString: "F4F6F6")
    var disableBtnTextColor : UIColor = UIColor.lightGray
    var unBlockTagArr : [Int] = [0,1,2]

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func initCurrencyType(currencyDelegate : CurrencyViewDelegate , isTitleHide : Bool) {
        self.currencyDelegate = currencyDelegate
        
        if isTitleHide {
            lblTitle.isHidden = true
        }else{
            lblTitle.isHidden = false
        }
    }
    func initCurrencyType(currencyDelegate : CurrencyViewDelegate , isTitleHide : Bool , currency : CurrencyType) {
        self.currencyDelegate = currencyDelegate
        
        if currency != nil{
            setCureencyFromController(txn: currency)
        }
        
        if isTitleHide {
            lblTitle.isHidden = true
        }else{
            lblTitle.isHidden = false
        }
    }

    @IBAction func onTapBtn(_ sender: UIButton) {
        for btn in btnTxn{
            for tag in unBlockTagArr{
                if btn.tag == tag {
                    btn.backgroundColor = defaultBtnColor
                    btn.setTitleColor(defaultBtnTextColor, for: .normal)
                }
            }
        }
        
        sender.backgroundColor = selectedBtnColor
        sender.setTitleColor(UIColor.white, for: .normal)
        
        if currencyDelegate != nil {
            var currency : CurrencyType = CurrencyType.USD
            if sender.tag == 0 {
                currency = CurrencyType.KHR
            }else if sender.tag == 1 {
                currency = CurrencyType.USD
            }else if sender.tag == 2 {
                currency = CurrencyType.THB
            }
            currencyDelegate.selectedCurrency(currency: currency, callBack: callBack)
        }
    }
    
    
    func setCureencyFromController(txn : CurrencyType){
        setCurrency(txn: txn, callback: 0)
    }
    
    private func setCurrency(txn : CurrencyType , callback : Int){
        var number = 0
        if txn == CurrencyType.KHR {
            number = 0
        }else if txn == CurrencyType.USD {
            number = 1
        }else if txn == CurrencyType.THB {
            number = 2

        }
        
        btnTxn[number].backgroundColor = selectedBtnColor
        btnTxn[number].setTitleColor(UIColor.white, for: .normal)
        
        if callback != 0 {
            currencyDelegate.selectedCurrency(currency: txn, callBack: callBack)
        }
    }
    
    func setAndGetCureency(currency : CurrencyType , callback : Int){
         setCurrency(txn: currency, callback: callback)
    }
       
    
    func setCureencyFromString(txn : String){
        
        var currncy : CurrencyType!
        var number = 0
        if txn == CurrencyType.KHR.rawValue {
            number = 0
            currncy = CurrencyType.KHR
        }else if txn == CurrencyType.USD.rawValue {
            number = 1
            currncy = CurrencyType.USD

        }else if txn == CurrencyType.THB.rawValue {
            number = 2
            currncy = CurrencyType.THB
        }
        
        for btn in btnTxn{
            for tag in unBlockTagArr{
                if btn.tag == tag {
                    btn.backgroundColor = defaultBtnColor
                    btn.setTitleColor(defaultBtnTextColor, for: .normal)
                }
            }
        }
        
        
        btnTxn[number].backgroundColor = selectedBtnColor
        btnTxn[number].setTitleColor(UIColor.white, for: .normal)
        
        currencyDelegate.selectedCurrency(currency: currncy, callBack: 1)

        
    }
    
    
    func hideTitle() {
        lblTitle.isHidden = true
    }
    
    
    func setBackGroundColor(color : UIColor , btnColor : UIColor , setSelectedcurrency : CurrencyType){
        viewbackground.backgroundColor = color
        defaultBtnColor = btnColor
        for btn in btnTxn{
            btn.backgroundColor = defaultBtnColor
        }
        
        setCureencyFromController(txn: setSelectedcurrency)
        
    }
    
    private func blockCurrencyType(currencyArr : [CurrencyType] , isNeedReturn : Bool) {
        unBlockTagArr.removeAll()
        for btn in btnTxn{
            btn.isEnabled = false
            btn.backgroundColor = disableBtnColor
            btn.setTitleColor(disableBtnTextColor, for: .normal)
        }
        
        for item in currencyArr{
            print(item)
            if item == CurrencyType.KHR{
                unBlockTagArr.append(0)
                btnTxn[0].isEnabled = true
                btnTxn[0].backgroundColor = defaultBtnColor
                btnTxn[0].setTitleColor(defaultBtnTextColor, for: .normal)
            }else if item == CurrencyType.USD{
                unBlockTagArr.append(1)
                btnTxn[1].isEnabled = true
                btnTxn[1].backgroundColor = defaultBtnColor
                btnTxn[1].setTitleColor(defaultBtnTextColor, for: .normal)
            }else if item == CurrencyType.THB{
                unBlockTagArr.append(2)
                btnTxn[2].isEnabled = true
                btnTxn[2].backgroundColor = defaultBtnColor
                btnTxn[2].setTitleColor(defaultBtnTextColor, for: .normal)
            }
        }
        
        if isNeedReturn{
            setCurrency(txn: CurrencyType.KHR, callback: 1)
        }else{
            if currencyArr.count == 1 {
                setCurrency(txn: currencyArr[0], callback: 1)
            }
        }
    }
    
    func blockCurrency(currencyArr : [CurrencyType]){
        blockCurrencyType(currencyArr: currencyArr, isNeedReturn: true)
    }
    
    
    func blockCurrencyFromString(stringArr : [String]){
        var currencyArr : [CurrencyType] = []
        
        for item in stringArr{
            if item == CurrencyType.KHR.rawValue {
                currencyArr.append(CurrencyType.KHR)
            }else if item == CurrencyType.USD.rawValue {
                currencyArr.append(CurrencyType.USD)
            }else if item == CurrencyType.THB.rawValue {
                currencyArr.append(CurrencyType.THB)
            }
        }
        
        blockCurrencyType(currencyArr: currencyArr, isNeedReturn: false)
    }
    
    
   
}
