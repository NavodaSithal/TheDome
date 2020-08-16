//
//  IpayTextInputField.swift
//  iPay
//
//  Created by Navoda on 11/26/19.
//  Copyright © 2019 iPay. All rights reserved.
//

import UIKit

class IpayTextInputField: UITextField {
    var enableMaterialPlaceHolder : Bool = true
    var placeholderAttributes = NSDictionary()
    var lblPlaceHolder = UILabel()
    var defaultFont = UIFont()
    var difference: CGFloat = 22.0
    var isUnderLineAvailabe : Bool = true
    
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var rightPadding: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Initialize ()
        placeholder = getLocalizedString(key: placeholder!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        placeholder = getLocalizedString(key: placeholder!)
        Initialize ()
    }
    
    func Initialize(){
        self.clipsToBounds = false
        self.addTarget(self, action: #selector(IpayTextInputField.textFieldDidChange), for: .editingChanged)
        self.EnableMaterialPlaceHolder(enableMaterialPlaceHolder: true)
        if isUnderLineAvailabe {
            let underLine = UIView()
            underLine.backgroundColor = UIColor.init(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 0.8)
            underLine.frame = CGRect(x: 0, y: self.frame.size.height-1, width : self.frame.size.width, height : 1)
            underLine.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
            underLine.clipsToBounds = true
            self.addSubview(underLine)
        }
        defaultFont = self.font!
    }
    
    func refresh(){
        //        self.placeholder = ""
        self.lblPlaceHolder.removeFromSuperview()
    }
    
    @IBInspectable var placeHolderColor: UIColor? = UIColor.lightGray {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder! as String ,
                                                            attributes:[NSAttributedStringKey.foregroundColor: placeHolderColor!])
        }
    }
    
    override internal var placeholder:String?  {
        didSet {
            //  NSLog("placeholder = \(placeholder)")
        }
        willSet {
            let atts  = [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.labelFontSize] as [NSAttributedStringKey : Any]
            self.attributedPlaceholder = NSAttributedString(string: newValue!, attributes:nil)
            self.EnableMaterialPlaceHolder(enableMaterialPlaceHolder: self.enableMaterialPlaceHolder)
        }
        
    }
    
    //    override internal var attributedText:NSAttributedString?  {
    //        didSet {
    //            //  NSLog("text = \(text)")
    //        }
    //        willSet {
    //            if (self.placeholder != nil) && (self.text != "")
    //            {
    //                let string = NSString(string : self.placeholder!)
    //                self.placeholderText(string)
    //            }
    //
    //        }
    //    }
    //
    //
    
    @objc func textFieldDidChange(){
        playAnimation()
    }
    
    func playAnimation(){
        if self.enableMaterialPlaceHolder {
            if (self.text == nil) || (self.text?.characters.count)! > 0 {
                self.lblPlaceHolder.alpha = 1
                self.attributedPlaceholder = nil
                self.lblPlaceHolder.textColor = self.placeHolderColor
                //                self.lblPlaceHolder.textColor = UIColor.darkGray
                
                let fontSize = self.font!.pointSize;
                self.lblPlaceHolder.font = UIFont.init(name: (self.font?.fontName)!, size: fontSize-4)
            }
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {() -> Void in
                if (self.text == nil) || (self.text?.characters.count)! <= 0 {
                    self.lblPlaceHolder.font = self.defaultFont
                    
                    //                    self.lblPlaceHolder.alpha = 0.0
                    //                    self.placeholder = self.lblPlaceHolder.text
                    
                    //                    self.placeHolderColor = UIColor.lightGray
                    
                    self.lblPlaceHolder.frame = CGRect(x: 30 + self.leftPadding, y : 0, width :self.frame.size.width, height : self.frame.size.height)
                    //                    self.lblPlaceHolder.removeFromSuperview()
                    //                    self.placeholder = self.lblPlaceHolder.text
                    
                }
                else {
                    self.lblPlaceHolder.frame = CGRect(x : 40, y : -self.difference, width : self.frame.size.width, height : self.frame.size.height)
                    
                }
            }, completion: {(finished: Bool) -> Void in
            })
        }
    }
    
    func EnableMaterialPlaceHolder(enableMaterialPlaceHolder: Bool){
        self.enableMaterialPlaceHolder = enableMaterialPlaceHolder
        self.lblPlaceHolder = UILabel()
        self.lblPlaceHolder.frame = super.leftViewRect(forBounds: bounds)
        self.lblPlaceHolder.alpha = 0
        self.lblPlaceHolder.clipsToBounds = true
        self.addSubview(self.lblPlaceHolder)
        self.lblPlaceHolder.attributedText = self.attributedPlaceholder
        //        print(self.attributedPlaceholder)
        //self.lblPlaceHolder.sizeToFit()
    }
    
    //    func placeholderText(_ placeholder: NSString){
    //        let atts  = [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.labelFontSize] as [NSAttributedStringKey : Any]
    //        self.attributedPlaceholder = NSAttributedString(string: placeholder as String , attributes:atts)
    //        self.EnableMaterialPlaceHolder(enableMaterialPlaceHolder: self.enableMaterialPlaceHolder)
    //    }
    
    override func becomeFirstResponder()->(Bool){
        let returnValue = super.becomeFirstResponder()
        return returnValue
    }
    
    override func resignFirstResponder()->(Bool){
        let returnValue = super.resignFirstResponder()
        return returnValue
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     UIEdgeInsetsMake(2, 40, 0, 10))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     UIEdgeInsetsMake(2, 40, 0, 10))
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     UIEdgeInsetsMake(2, 40, 0, 10))
    }
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    // Provides right padding for images
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRight = super.rightViewRect(forBounds: bounds)
        
        textRight.origin.x -= rightPadding
        
        return textRight
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
            
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
//            updateView()
            rightViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
            imageView.image = rightImage
//            imageView.backgroundColor = .purple
            //            imageView.tintColor = color
            rightView = imageView
        }
    }
    
    //    @IBInspectable var color: UIColor = UIColor.white {
    //        didSet {
    //            updateView()
    //        }
    //    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
            imageView.image = image
            //            imageView.tintColor = color
            leftView = imageView
        } else if let image = rightImage {
            rightViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 18, height: 18))
            imageView.image = image
            imageView.backgroundColor = .purple
            //            imageView.tintColor = color
            rightView = imageView
        } else {
            leftViewMode = UITextFieldViewMode.never
            rightViewMode = UITextFieldViewMode.never
            leftView = nil
            rightView = nil
        }
    }
}
