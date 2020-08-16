//
//  ErrorPopupViewController.swift
//  iPay
//
//  Created by Thushara Wijekoon on 2/22/18.
//  Copyright © 2018 iPay. All rights reserved.
//

import Foundation
import UIKit

protocol clickPopupButtonDelegate {
    func clickButton (callBackIndex : Int)
}

class ErrorPopupViewController : CustomRootViewController {
    
    @IBOutlet weak var lblErrorTitle: UILabel!
    @IBOutlet weak var lblErrorMessage: UILabel!
    @IBOutlet weak var ivErrorTop: UIImageView!
    public var titleMessege : String = ""
    public var errorMessage : String = ""
    public var btnText : String = ""
    public var isError : Bool = false
    public var popUpType : Int = 0

    @IBOutlet weak var btnClose: IpayButton!
    
    var clickDelegate : clickPopupButtonDelegate? = nil
    var callbackIndex : Int = 0
    
    
    @IBAction func clickButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        clickDelegate?.clickButton(callBackIndex: callbackIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblErrorTitle.text = titleMessege
        lblErrorMessage.text = errorMessage
        btnClose.setTitle(btnText, for: .normal)
        
        if popUpType == 0 {
            ivErrorTop.image = #imageLiteral(resourceName: "error")
            btnClose.backgroundColor = UIColor(hexString: "f04747")
            lblErrorTitle.textColor = UIColor(hexString: "f04747")
        }
        else if popUpType == 1 {
            ivErrorTop.image = #imageLiteral(resourceName: "success")
            btnClose.backgroundColor = UIColor(hexString: "6cc57a")
            lblErrorTitle.textColor = UIColor(hexString: "6cc57a")
        }
        else if popUpType == 2 {
            ivErrorTop.image = #imageLiteral(resourceName: "warning")
            btnClose.backgroundColor = UIColor(hexString: "F2B646")
            lblErrorTitle.textColor = UIColor(hexString: "F2B646")
        }
        else if popUpType == 3 {
            ivErrorTop.image = #imageLiteral(resourceName: "oooops")
            btnClose.backgroundColor = UIColor(hexString: "BFC2C4")
            lblErrorTitle.textColor = UIColor(hexString: "BFC2C4")
        }
        else if popUpType == 4 {
            // cooming soon
            ivErrorTop.image = #imageLiteral(resourceName: "comingsoon")
            btnClose.backgroundColor = UIColor(hexString: "0D7EF0")
            lblErrorTitle.textColor = UIColor(hexString: "0D7EF0")
        }else if popUpType == 5 {
            // revarsal
            ivErrorTop.image = #imageLiteral(resourceName: "reversal")
            btnClose.backgroundColor = UIColor(hexString: "F85835")
            lblErrorTitle.textColor = UIColor(hexString: "F85835")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
