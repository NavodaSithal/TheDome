//
//  SuccessMessageHandler.swift
//  iPay
//
//  Created by Chandana Pathirage on 3/25/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import UIKit

class SuccessMessageHandler: NSObject {
    
    private var uiViewController: UIViewController?
    
//    // inizialize
//    init(uiViewController: UIViewController) {
//        self.uiViewController = uiViewController
//    }
//    
//    
//    func successMessage(successMessage: String, backUIViewControllerID: String, continueUIViewControllerID: String, backStoryboardName: String, continueStoryboardName: String) -> Void {
//        //self.uiViewController?.performSegue(withIdentifier: identifier, sender: self.uiViewController)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let scene: SuccessMessageViewController = storyboard.instantiateViewController(withIdentifier: "SuccessMessageViewController") as! SuccessMessageViewController
//        scene.setMessage(message: successMessage)
//        scene.setBackStoryboardName(backStoryboardName: backStoryboardName)
//        scene.setContinueStoryboardName(continueStoryboardName: continueStoryboardName)
//        scene.setContinueUIViewControllerID(continueUIViewControllerID: continueUIViewControllerID)
//        scene.setBackUIViewControllerID(backUIViewControllerID: backUIViewControllerID)
//        
//        //self.uiViewController?.performSegue(withIdentifier: identifier, sender: self.uiViewController)
//        self.uiViewController?.navigationController?.pushViewController(scene, animated: false)
//    }
//    
//    func successMessage(successMessage: String) -> Void {
//        //self.uiViewController?.performSegue(withIdentifier: identifier, sender: self.uiViewController)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let scene: SuccessMessageViewController = storyboard.instantiateViewController(withIdentifier: "SuccessMessageViewController") as! SuccessMessageViewController
//        scene.setMessage(message: successMessage)
//        //self.uiViewController?.performSegue(withIdentifier: identifier, sender: self.uiViewController)
////        self.uiViewController?.navigationController?.pushViewController(scene, animated: true)
//        
//        if self.uiViewController?.navigationController != nil {
//            self.uiViewController?.navigationController?.pushViewController(scene, animated: true)
//        }else {
//            UIApplication.shared.keyWindow?.rootViewController?.present(scene, animated: false, completion:  nil)
//        }
//    }
//    
//    func successMessage(successMessage: String, tabName: String) -> Void {
//        //self.uiViewController?.performSegue(withIdentifier: identifier, sender: self.uiViewController)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let scene: SuccessMessageViewController = storyboard.instantiateViewController(withIdentifier: "SuccessMessageViewController") as! SuccessMessageViewController
//        scene.setMessage(message: successMessage)
//        if tabName == "Home" {
//            scene.setGoToHomeTab(goToHomeTab: true)
//        } else if tabName == "My iPay" {
//            scene.setGoToMyIPatTab(goToMyIPatTab: true)
//        } else if tabName == "LOGOUT" {
//            scene.setIsLogout(isLogout: true)
//        }
//        //self.uiViewController?.performSegue(withIdentifier: identifier, sender: self.uiViewController)
//        self.uiViewController?.navigationController?.pushViewController(scene, animated: false)
//    }
}
