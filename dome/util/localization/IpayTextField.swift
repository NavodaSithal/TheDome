//
//  IpayTextField.swift
//  iPay
//
//  Created by Thushara Wijekoon on 11/23/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import UIKit

class IpayTextField : UITextField {
    
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var rightPadding: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        placeholder = getLocalizedString(key: placeholder!)
        
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
        
        textRight.origin.x += rightPadding
        
        return textRight
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var color: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
            imageView.image = image
            imageView.tintColor = color
            leftView = imageView
        } else if let image = rightImage {
            rightViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
            imageView.image = image
            imageView.tintColor = color
            rightView = imageView
        } else {
            leftViewMode = UITextFieldViewMode.never
            rightViewMode = UITextFieldViewMode.never
            leftView = nil
            rightView = nil
        }
    }
}

private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
}

extension String
{
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
    
    func currencyFormatter (maxLength : Int , string : String,amount : String, amountToPayTextField: UITextField) -> String {
        var returnVal : String = ""
        if string != "" { // handle backspace
            guard (Double(string) != nil) || string == "." else {
                return amount
            }
            
            if amount.count < maxLength {
                let ttt = "\(amount)\(string)"
                let arr = ttt.components(separatedBy: ("."))
                if (arr.count  > 2 && string == ".") {
                    return amount
                }else if (arr.count == 2 && arr[1].count > 2) {
                    return amount
                }
                
                if amount == "" && string == "."{
                    return amount
                }
                returnVal = "\(amount)\(string)"
                let text : String = Double(arr[0])!.formattedWithSeparatorWithoutOnTime
                amountToPayTextField.text = text
                if string == "." {
                    amountToPayTextField.text = "\(text)."
                }
                if arr.count > 1 && arr[1].count > 0 {
                    amountToPayTextField.text = "\(text).\(arr[1])"
                }
                return returnVal
            }else{
                return amount
            }
        }
        
        let truncated = amount.substring(to: amount.index(before: amount.endIndex))
        returnVal = truncated
        if returnVal != "" {
            let arr = returnVal.components(separatedBy: ("."))
            
            let text : String = Double(arr[0])!.formattedWithSeparatorWithoutOnTime
            if arr.count > 1 && arr[1].count > 0 {
                amountToPayTextField.text = "\(text).\(arr[1])"
            }else{
                amountToPayTextField.text = text
            }

            if truncated.last == "."{
                amountToPayTextField.text = "\(text)."
            }
        }else{
            amountToPayTextField.text = returnVal
        }
        return returnVal
    }
}

