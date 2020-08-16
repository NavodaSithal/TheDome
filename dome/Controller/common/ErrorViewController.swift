//
//  ErrorViewController.swift
//  iPay
//
//  Created by Chandana Pathirage on 3/27/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import UIKit

class ErrorViewController: CustomRootViewController {
    
    @IBOutlet weak var errorMessage: UILabel!
    private var message:String?
    private var backUIViewControllerID:String?
    private var backStoryboardName: String?
    private var continueUIViewControllerID:String?
    private var continueStoryboardName: String?
    
    private var goToHomeTab: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.errorMessage.text = self.message
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setErrorMessage(message: String) -> Void {
        self.message = message
    }
    
    @IBAction func backButtton(_ sender: Any) {
        if self.backStoryboardName != nil {
            let storyboard = UIStoryboard(name: self.backStoryboardName!, bundle: nil)
            let scene: UIViewController = storyboard.instantiateViewController(withIdentifier: self.backUIViewControllerID!)
            //self.uiViewController?.performSegue(withIdentifier: identifier, sender: self.uiViewController)
            self.navigationController?.pushViewController(scene, animated: true)
        } else if goToHomeTab {
            self.goToTab(index: 2)
        } else {
            print("dismiss")
            //self.dismiss(animated: false, completion: nil)
            self.navigationController?.popViewController(animated: true)
             self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func continueUIButton(_ sender: Any) {
        if self.continueStoryboardName != nil {
            let storyboard = UIStoryboard(name: self.continueStoryboardName!, bundle: nil)
            let scene: UIViewController = storyboard.instantiateViewController(withIdentifier: self.continueUIViewControllerID!)
            //self.uiViewController?.performSegue(withIdentifier: identifier, sender: self.uiViewController)
            self.navigationController?.pushViewController(scene, animated: true)
        } else if goToHomeTab {
            self.goToTab(index: 2)
        } else {
            print("dismiss")
            //self.dismiss(animated: false, completion: nil)
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
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
