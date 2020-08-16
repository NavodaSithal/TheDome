//
//  TwoButtonPopupVC.swift
//  iPay
//
//  Created by Thushara Wijekoon on 8/6/19.
//  Copyright © 2019 iPay. All rights reserved.
//

import Foundation
import UIKit

class TwoButtonPopupVC : CustomRootViewController {
    
    @IBOutlet var lblMsg: IpayLabel!
    @IBOutlet var lbltitle: IpayLabel!
    @IBOutlet var imgIcon: UIImageView!
    @IBOutlet weak var btnOne: IpayButton!
    @IBOutlet weak var btnTwo: IpayButton!
    
    public var mainTitle : String = ""
    public var message : String = ""
    public var btnOneText : String = ""
    public var btnTwoText : String = ""
    public var iconName : String = ""
    
    @IBOutlet weak var icconHeight: NSLayoutConstraint!
    @IBOutlet weak var popUpHeight: NSLayoutConstraint!
    var onPressButtonOne : (() -> Void)?
    var onPressButtonTwo : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnOne.cornerRadius = 10
        btnTwo.cornerRadius = 10
        
        if(mainTitle == ""){
            lbltitle.isHidden = true
        }else{
            lbltitle.text = mainTitle
        }
        
        if(iconName == ""){
            imgIcon.isHidden = true
            icconHeight.constant = 0;
            popUpHeight.constant = 250
        }else{
             imgIcon.image = UIImage(named: iconName)
        }
        lblMsg.text = message
        btnOne.setTitle(btnOneText, for: .normal)
        btnTwo.setTitle(btnTwoText, for: .normal)
    }
    
    @IBAction func onTapOne(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.onPressButtonOne!()
    }
    
    @IBAction func onTapTwo(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.onPressButtonTwo!()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
