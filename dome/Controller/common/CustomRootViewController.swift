//
//  CustomRootViewController.swift
//  iPay
//
//  Created by Sinnathamby Shanmugarajah on 4/2/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import UIKit

@objc protocol NotifcationCountDelegate {
    @objc optional func getNotificationCount()
}

class CustomRootViewController: UIViewController  ,clickPopupButtonDelegate {
    
    public var rooSettings: Settings?
    public var rootAuthManager: AuthenticationManager? = nil
    public var comManager : SslCommunicationManager? = nil
    var customActivityIndicator: CustomActivityIndicator? = nil
    private let noAccountsErrorCallback = 2
    static var notificatiuonCountDelegate : NotifcationCountDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        if(self.rooSettings == nil ){
            self.rooSettings = Settings()
        }
        if(self.comManager == nil ){
            self.comManager = SslCommunicationManager()
        }
        if(self.rootAuthManager == nil ){
            self.rootAuthManager = AuthenticationManager(uiViewController: self, comMan : comManager!)
            self.customActivityIndicator = self.rootAuthManager?.customActivityIndicator
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.darkGray]
        self.navigationItem.titleView?.tintColor = UIColor.white
        self.hideKeyboardWhenTappedAround()
    }
    
    func clickButton(callBackIndex: Int) {
    }
    
    func applyKhmerFont()  {
        IpayLabel.appearance().substituteFontName = "KhmerOSSiemreap";
        IpayButton.appearance().substituteFontName = "KhmerOSSiemreap";
        UITextField.appearance().substituteFontName = "KhmerOSSiemreap";
    }
    
    func applyEnglishFont(){
        IpayLabel.appearance().substituteFontName = "ProximaNovaCond-Regular";
        IpayButton.appearance().substituteFontName = "ProximaNovaCond-Regular";
        UITextField.appearance().substituteFontName = "ProximaNovaCond-Regular";
    }
    
}

extension Date {
    static func dateDifference(fromDate: Date) -> Int {
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let today : Date = Date()
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: fromDate, to: today);
        return difference.second!
    }
}

extension UIViewController{
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool
//    {
//        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? IpayTextField {
//            nextField.becomeFirstResponder()
//        } else {
//            textField.resignFirstResponder()
//        }
//        return false
//    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func gotoMenu(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuVc
        self.present(vc, animated: true, completion: nil)
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
