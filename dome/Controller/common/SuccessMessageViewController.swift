//
//  SuccessMessageViewController.swift
//  iPay
//
//  Created by Chandana Pathirage on 3/28/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import UIKit

class SuccessMessageViewController: CustomRootViewController {
    
    @IBOutlet weak var successMessageUILabel: UILabel!
    private var message:String?
    private var backUIViewControllerID:String?
    private var backStoryboardName: String?
    private var continueUIViewControllerID:String?
    private var continueStoryboardName: String?
    
    private var goToHomeTab: Bool = false
    private var goToMyIPatTab: Bool = false
    private var isLogout: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.successMessageUILabel.text = self.message
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if goToHomeTab {
            let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.goToTab(index: 2)
            }
        } else if goToMyIPatTab {
            let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                //self.goToTab(index: 4)
            }
        }
    }

    @IBAction func backButton(_ sender: Any) {
        if self.backStoryboardName != nil {
            let storyboard = UIStoryboard(name: self.backStoryboardName!, bundle: nil)
            let scene: UIViewController = storyboard.instantiateViewController(withIdentifier: self.backUIViewControllerID!)
            //self.uiViewController?.performSegue(withIdentifier: identifier, sender: self.uiViewController)
            self.navigationController?.pushViewController(scene, animated: true)
        } else if goToHomeTab {
            self.goToTab(index: 2)
        }else if isLogout {
            AuthenticationManager(uiViewController: self).logout()
        }  else  {
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if self.continueStoryboardName != nil {
//            if continueUIViewControllerID == "CustomerVerify" {
//                print("CustomerVerify")
//                let mainView: UIStoryboard = UIStoryboard(name: continueStoryboardName!, bundle: nil)
//                
//                let payNavigator : UINavigationController = mainView.instantiateViewController(withIdentifier: "RegisteationNavigator") as! UINavigationController
//                
//                let viewcontroller : CustomerVerificationViewController = mainView.instantiateViewController(withIdentifier: continueUIViewControllerID!) as! CustomerVerificationViewController
//                
//                self.navigationController?.pushViewController(viewcontroller, animated: true)
//                present(payNavigator, animated:true , completion: nil)
//            } else {
                let storyboard = UIStoryboard(name: self.continueStoryboardName!, bundle: nil)
                let scene: UIViewController = storyboard.instantiateViewController(withIdentifier: self.continueUIViewControllerID!)
                //self.uiViewController?.performSegue(withIdentifier: identifier, sender: self.uiViewController)
                self.navigationController?.pushViewController(scene, animated: true)
//            }
        } else if goToHomeTab {
            self.goToTab(index: 2)
        } else if self.goToMyIPatTab {
            self.goToTab(index: 4)
        } else if isLogout {
            AuthenticationManager(uiViewController: self).logout()
        } else {
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func setMessage(message: String) -> Void {
        self.message = message
    }
    
    func setBackUIViewControllerID(backUIViewControllerID: String) -> Void {
        self.backUIViewControllerID = backUIViewControllerID;
    }
    
    func setContinueUIViewControllerID(continueUIViewControllerID: String) -> Void {
        self.continueUIViewControllerID = continueUIViewControllerID;
    }
    
    func setBackStoryboardName(backStoryboardName: String) -> Void {
        self.backStoryboardName = backStoryboardName
    }

    func setContinueStoryboardName(continueStoryboardName: String) -> Void {
        self.continueStoryboardName = continueStoryboardName
    }
    
    func setGoToHomeTab(goToHomeTab: Bool) -> Void {
        self.goToHomeTab = goToHomeTab
        self.goToMyIPatTab = !goToHomeTab
    }
    
    func setGoToMyIPatTab(goToMyIPatTab: Bool) -> Void {
        self.goToMyIPatTab = goToMyIPatTab
        self.goToHomeTab = !goToMyIPatTab
    }
    
    func setIsLogout(isLogout: Bool) -> Void {
        self.isLogout = isLogout
    }
    
    func goToTab(index: Int) -> Void {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // Select Home Tab Bar
        tabBarController.selectedIndex = index
        appDelegate.window?.rootViewController = tabBarController
    }
}
