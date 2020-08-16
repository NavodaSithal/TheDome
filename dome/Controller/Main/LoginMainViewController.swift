//
//  LoginMainViewController.swift
//  iPay
//
//  Created by Chandana Pathirage on 7/18/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import UIKit

class LoginMainViewController: CustomRootViewController {

    @IBOutlet weak var noBtn: IpayButton!
    @IBOutlet weak var yesBtn: IpayButton!
    
    @IBOutlet weak var yesnoUiView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         yesnoUiView.layer.shadowOpacity = 0.7
         yesnoUiView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
         yesnoUiView.layer.shadowRadius = 15.0
         yesnoUiView.layer.shadowColor = UIColor.black.cgColor
         view.backgroundColor = UIColor.black
        
    }

    @IBAction func customerRegister(_ sender: Any) {
        
        let mainView: UIStoryboard!  = UIStoryboard(name: "Register", bundle: nil)
        let navigator : UINavigationController = mainView.instantiateViewController(withIdentifier: "RegisteationNavigator") as! UINavigationController
        let viewcontroller : RegisterFirstScreen = mainView.instantiateViewController(withIdentifier: "RegisterFirst") as! RegisterFirstScreen
        navigator.pushViewController(viewcontroller, animated: true)
        self.present(navigator, animated:true , completion: nil)
        
    }
    
    @IBAction func customerLogin(_ sender: Any) {
        
        let mainView: UIStoryboard!  = UIStoryboard(name: "Main", bundle: nil)
        let navigator : UINavigationController = mainView.instantiateViewController(withIdentifier: "MainNavigatorScene") as! UINavigationController
        let viewcontroller : LoginViewController = mainView.instantiateViewController(withIdentifier: "SignIn") as! LoginViewController
        navigator.pushViewController(viewcontroller, animated: true)
        self.present(navigator, animated:true , completion: nil)
        
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let registerScene = storyboard.instantiateViewController(withIdentifier: "LanguageView")
        //self.navigationController?.pushViewController(registerScene, animated: true)
        let payNavigator : UINavigationController = storyboard.instantiateViewController(withIdentifier: "MainNavigatorScene") as! UINavigationController
        payNavigator.pushViewController(registerScene, animated: true)
        present(payNavigator, animated:true , completion: nil)
    }
}
