//
//  IpayExtensions.swift
//  iPay
//
//  Created by Navoda on 11/26/19.
//  Copyright © 2019 iPay. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox


extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Double{
    
    var formattedWithSeparatorWithoutOnTime: String {
        let a = Formatter.withSeparator.string(for: self)
        let final : String =  a ?? "0"
        return final
    }
}

extension String{
    var formattedWithSeparatorWithoutRS: String {
        guard let amount = Double(self) else {
            return "0.00"
        }
        
        let doubleStr = String(format: "%.2f", amount)
        let arr = doubleStr.components(separatedBy: ".")
        let a = Formatter.withSeparator.string(for: Double(arr[0]))
        var final : String!
        final = "\(a!).\(arr[1])"
        return final
    }
}

extension UIImageView{
//    func setLogo(logo : String, imgView : UIImageView, localImg : String){
//        if logo != "" {
//            imgView.sd_setImage(with: URL(string: logo))
//        }
//        else{
//            imgView.image =  UIImage(named: localImg)
//        }
//        
//        imgView.contentMode = .scaleAspectFit
//        imgView.layer.cornerRadius = imgView.frame.height/2
//        imgView.clipsToBounds = true
//        
//    }
}

extension String{
    
    var getImagePath : String{
           let timestamp = NSDate().timeIntervalSince1970
           let s  = "\(timestamp)"
           let fs = s.replacingOccurrences(of: ".", with: "")
        let final = "\(self)_\(fs).jpg"
           return final
       }
    
    var checkUsernameCharacter : String {
        let aSet = NSCharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyz0123456789_").inverted
        let compSepByCharInSet = self.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return numberFiltered
    }
    
    var checkPasswordCharacter : String {
        let aSet = NSCharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_!#$%()*+-.:;=?@^{}~").inverted
        let compSepByCharInSet = self.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return numberFiltered
    }
    
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x2600...0x26FF,   // Misc symbols
            0x2700...0x27BF,   // Dingbats
            0xFE00...0xFE0F,   // Variation Selectors
            0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
            0x1F1E6...0x1F1FF: // Flags
                return true
            default:
                continue
            }
        }
        return false
    }
    
    var amexNumber: String{
        var final = ""
        for (index , element) in self.enumerated() {
            if index == 4 || index == 10 {
                final = "\(final) \(element)"
            }else {
                final = "\(final)\(element)"
            }
        }
        return final
    }
    
    var sepFourByFour :String{
        var final = ""
        for (index , element) in self.enumerated() {
            if (index+1)%4 == 1 && index != 0{
                final = "\(final) \(element)"
            }
            else{
                final = "\(final)\(element)"
            }
        }
        return final
    }
    
    func IpayDateFormatWithoutTime(thisdate: String) -> String! {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = getLocal()

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MM/yyyy"
        dateFormatterPrint.locale = getLocal()

//        let lang = LanguageManager.sharedInstance.getSelectedLocale()
//        if lang == "km" {
//            dateFormatter.locale = Locale(identifier: "km_KH_POSIX")
//            dateFormatterPrint.locale = Locale(identifier: "km_KH_POSIX")
//        }else{
//            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//            dateFormatterPrint.locale = Locale(identifier: "en_US_POSIX")
//        }

        let date = dateFormatter.date(from: thisdate)
        let day = calendar.component(.day, from: date!)

        let dayLbl = "\(String(format: "%02d", day))\(daySuffix(from: day))"
        let lblDay = "\(dayLbl)/\(dateFormatterPrint.string(from: date!))"

        return lblDay
    }
    
    func IpayDateFormat(thisdate: String) -> String! {
//        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        dateFormatter.locale = getLocal()
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy HH:mm"
        dateFormatterPrint.locale = getLocal()

//        let lang = LanguageManager.sharedInstance.getSelectedLocale()
//        if lang == "km" {
//            dateFormatter.locale = Locale(identifier: "km_KH_POSIX")
//            dateFormatterPrint.locale = Locale(identifier: "km_KH_POSIX")
//        }else{
//            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//            dateFormatterPrint.locale = Locale(identifier: "en_US_POSIX")
//        }
        
        let date = dateFormatter.date(from: thisdate)
//        let day = calendar.component(.day, from: date!)
//
//        let dayLbl = "\(String(format: "%02d", day))\(daySuffix(from: day))"
        let lblDay = "\(dateFormatterPrint.string(from: date!))"
        
        return lblDay
    }
    
    var scheduleDateFormat : String{
//        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = getLocal()
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        dateFormatterPrint.locale = getLocal()

//        let lang = LanguageManager.sharedInstance.getSelectedLocale()
//        if lang == "km" {
//            dateFormatter.locale = Locale(identifier: "km_KH_POSIX")
//            dateFormatterPrint.locale = Locale(identifier: "km_KH_POSIX")
//        }else{
//            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//            dateFormatterPrint.locale = Locale(identifier: "en_US_POSIX")
//        }
        let date = dateFormatter.date(from: self)
        return dateFormatterPrint.string(from: date!)
    }
    
    var dashToSlashDate : String {
        
        guard self != "" else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = getLocal()
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        dateFormatterPrint.locale = getLocal()
        
        let date = dateFormatter.date(from: self)
        return dateFormatterPrint.string(from: date!)
    }
    
    
    var dashDateWithoutTime : String {
        
        guard self != "" else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = getLocal()
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd-MM-yyyy"
        dateFormatterPrint.locale = getLocal()
        
        let date = dateFormatter.date(from: self)
        return dateFormatterPrint.string(from: date!)
    }
    
    
    func getLocal() -> Locale{
        let lang = LanguageManager.sharedInstance.getSelectedLocale()
        var local : Locale!
        if lang == "km" {
            local = Locale(identifier: "km_KH_POSIX")
        }else{
            local = Locale(identifier: "en_US_POSIX")
        }
        return local
    }
    
    func daySuffix(from dayOfMonth: Int) -> String {
        switch dayOfMonth {
        case 1, 21, 31: return "st"
        case 2, 22: return "nd"
        case 3, 23: return "rd"
        default: return "th"
        }
    }
    
    
    func paswordStrenth(psw : String , reg : String) -> Bool {
        let result = psw.range(of: reg, options: .regularExpression) != nil
        return result
    }
    
    func setPasswordValidation(txt : UITextField , lbl : UILabel , text : String) -> Bool{
        
//        self.addTarget(self, action: #selector(IpayTextInputField.textFieldDidChange), for: .editingChanged)
        
        var psw = "\(txt.text!)\(text)"
        var numberFiltered : String = ""
        
        if text == ""{
            psw = txt.text!
            psw = psw.substring(to: psw.index(before: psw.endIndex))
        }else{
            let aSet = NSCharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_!#$%()*+-.:;=?@^{}~").inverted

//            let aSet = NSCharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_!#$%()*+-.:;=?@^{}~").inverted
            let compSepByCharInSet = text.components(separatedBy: aSet)
            numberFiltered = compSepByCharInSet.joined(separator: "")
            psw = "\(txt.text!)\(numberFiltered)"
        }
        
        let strenth = getPasswordStrenth(psw: psw)
        
        setStrenth(strenth: strenth, lbl: lbl)
        return text == numberFiltered
    }
    
    
    func setPswStrenth(txt : UITextField, lbl : UILabel){
        let strenth = getPasswordStrenth(psw: txt.text!)
        
        setStrenth(strenth: strenth, lbl: lbl)
    }
    
    
    
    func getPasswordStrenth(psw : String) -> Int{
        var strenth: Int  = 0
        var minus : Int = 0
        
        if psw.count > 0 && psw.count < 8 {
            strenth = 0
            
        }else {
            print(psw)
            if paswordStrenth(psw: psw, reg: "^(.*[0-9]).*([0-9].*)$"){
                minus += 1
            }else if paswordStrenth(psw: psw, reg: "^(.*[0-9].*)$"){
                strenth += 1
                minus += 1
            }
            
            if paswordStrenth(psw: psw, reg: "^(.*[a-zA-Z].*[a-zA-Z].*)$"){
                minus += 1
            }else if paswordStrenth(psw: psw, reg: "^(.*[a-zA-Z].*)$"){
                strenth += 1
                minus += 1
            }
            
            if paswordStrenth(psw: psw, reg: "^(.*[!#$%&()*+-.:;<=>?@^_{}~].*[!#$%&()*+-.:;<=>?@^_{}~].*)$"){
                minus += 1
            }else if paswordStrenth(psw: psw, reg: "^(.*[!#$%&()*+-.:;<=>?@^_{}~].*)$"){
                strenth += 1
                minus += 1
            }
            
//            if paswordStrenth(psw: psw, reg: "^(.*[!,#,$,%,&,(,),*,+,-,.,:,;,<,=,>,?,@,^,_,{,},~].*[!,#,$,%,&,(,),*,+,-,.,:,;,<,=,>,?,@,^,_,{,},~].*)$"){
//                minus += 1
//            }else if paswordStrenth(psw: psw, reg: "^(.*[!#$%&()*+-.:;<=>?@^_{}~].*)$"){
//                strenth += 1
//                minus += 1
//            }
            
            if minus <= 1 {
                strenth = 1
            }else if minus == 2 && strenth == 1 {
                strenth = 2
            }else if minus == 2 {
                strenth = 3
            }
            else if minus == 3{
                strenth = 4
            }
        }
        return strenth
    }
    
    func setStrenth(strenth : Int, lbl : UILabel){
        lbl.isHidden = false
        var color : UIColor = .white
        var textStrenth : String = ""
        if strenth == 0 {
            textStrenth = getLocalizedString(key: "too_short")
            color = .red
        }
        else if strenth < 2 {
            textStrenth = getLocalizedString(key: "invalid")
            color = .red
        }else if strenth == 2{
            textStrenth = getLocalizedString(key: "weak")
            color = .orange
        }else if strenth <= 3{
            textStrenth = getLocalizedString(key: "good")
            color = UIColor(hexString: "ffc131")
        }else if strenth > 3{
            textStrenth = getLocalizedString(key: "strong")
            color = .green
        }
        
        lbl.text = textStrenth
        lbl.textColor = color
    }
}

extension Double {
    struct Number {
        static let formatter = NumberFormatter()
    }
    
    var twoDigits: String {
        Number.formatter.numberStyle = NumberFormatter.Style.currency
        Number.formatter.minimumFractionDigits = 2
        Number.formatter.maximumFractionDigits = 2
        return Number.formatter.string(from: NSNumber(value: self))!
    }
}

extension String {
    var numbersOnly: String {
        //        return "".join(componentsSeparatedByCharactersIn(NSCharacterSet.decimalDigitCharacterSet().invertedSet))
        //        let arr = ["",components(separatedBy: NSCharacterSet.decimalDigits.inverted)] as! [String]
        //        return arr.joined(separator: "")
        return "\(components(separatedBy: NSCharacterSet.decimalDigits.inverted))"
    }
    var integerValue: Int {
        return decimalNumber.intValue
    }
    var decimalNumber: NSNumber {
        return NSDecimalNumber(string: self)
    }
    
    subscript(_ i: Int) -> String {
        let idx1 = index(startIndex, offsetBy: i)
        let idx2 = index(idx1, offsetBy: 1)
        return String(self[idx1..<idx2])
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }
    
    subscript (r: CountableClosedRange<Int>) -> String {
        let startIndex =  self.index(self.startIndex, offsetBy: r.lowerBound)
        let endIndex = self.index(startIndex, offsetBy: r.upperBound - r.lowerBound)
        return String(self[startIndex...endIndex])
    }
    
}

extension UIView {
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func setGradientTopToBottom (col1 : UIColor, col2 : UIColor) {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [col1.cgColor,col2.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = bounds

//        gradient.frame = self.frame
//        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
//        print(self.frame , "//" , self.bounds , "//" ,self.superview?.frame)
        layer.insertSublayer(gradient, at: 0)
    }
    
    func  removeLayers(){
        layer.sublayers?.remove(at: 0)
    }
}

extension UIButton{
    func getImageViewFront(){
        if let imageView = imageView {
            bringSubview(toFront: imageView)
        }
    }
}

extension CAShapeLayer {
    func drawCircleAtLocation(location: CGPoint, withRadius radius: CGFloat, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        let origin = CGPoint(x: location.x - radius, y: location.y - radius)
        path = UIBezierPath(ovalIn: CGRect(origin: origin, size: CGSize(width: radius * 2, height: radius * 2))).cgPath
    }
}

private var handle: UInt8 = 0;

extension UIBarButtonItem {

    private var badgeLayer: CAShapeLayer? {
        if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject? {
            return b as? CAShapeLayer
        } else {
            return nil
        }
    }
    
    func addBadge(number: Int, withOffset offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor.red, andFilled filled: Bool = true) {
        guard let view = self.customView else { return }
        badgeLayer?.removeFromSuperlayer()
        print(view.bounds.width)
        // Initialize Badge
        let badge = CAShapeLayer()
        let radius = CGFloat(8)
        let location = CGPoint(x: view.frame.width - (radius + (-7)), y: (radius + offset.y))
        badge.drawCircleAtLocation(location: location, withRadius: radius, andColor: color, filled: true)
        view.layer.addSublayer(badge)

        // Initialiaze Badge's label
        let label = CATextLayer()
        label.string = "\(number)"
        label.alignmentMode = kCAAlignmentCenter
        label.fontSize = 10
        label.frame = CGRect(origin: CGPoint(x: location.x-8, y: offset.y+1), size: CGSize(width: 16, height: 16))
        label.foregroundColor = filled ? UIColor.white.cgColor : color.cgColor
        label.backgroundColor = UIColor.clear.cgColor
        label.contentsScale = UIScreen.main.scale
        badge.addSublayer(label)

        // Save Badge as UIBarButtonItem property
        objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func updateBadge(number: Int) {
        if let text = badgeLayer?.sublayers?.filter({ $0 is CATextLayer }).first as? CATextLayer {
            if number > 99{
                text.string = "99+"
            }else{
                text.string = "\(number)"
            }
        }
    }

    func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }
}

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

