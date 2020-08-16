//
//  AuthenticationErrorHandler.swift
//  iPay
//
//  Created by Chandana Pathirage on 3/25/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import UIKit

class ErrorMessageHandler: NSObject {
    
    private var uiViewController: UIViewController?
    
    init(uiViewController: UIViewController) {
        self.uiViewController = uiViewController
    }
    
//    func errorMessage(errorMessage: String, errorType: String, backUIViewControllerID: String, continueUIViewControllerID: String, backStoryboardName: String, continueStoryboardName: String) -> Void {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let scene: ErrorViewController = storyboard.instantiateViewController(withIdentifier: "ErrorMessageViewController") as! ErrorViewController
//        scene.setErrorMessage(message: errorMessage)
//        scene.setBackStoryboardName(backStoryboardName: backStoryboardName)
//        scene.setContinueStoryboardName(continueStoryboardName: continueStoryboardName)
//        scene.setContinueUIViewControllerID(continueUIViewControllerID: continueUIViewControllerID)
//        scene.setBackUIViewControllerID(backUIViewControllerID: backUIViewControllerID)
//        //self.uiViewController?.performSegue(withIdentifier: identifier, sender: self.uiViewController)
//        self.uiViewController?.navigationController?.pushViewController(scene, animated: false)
//    }
//
//    func errorMessage(errorMessage: String, errorType: String, continueUIViewControllerID: String, continueStoryboardName: String) -> Void {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let scene: ErrorViewController = storyboard.instantiateViewController(withIdentifier: "ErrorMessageViewController") as! ErrorViewController
//        scene.setErrorMessage(message: errorMessage)
//        scene.setContinueStoryboardName(continueStoryboardName: continueStoryboardName)
//        scene.setContinueUIViewControllerID(continueUIViewControllerID: continueUIViewControllerID)
////        self.uiViewController?.navigationController?.pushViewController(scene, animated: true)
//
//        if self.uiViewController?.navigationController != nil {
//                            self.uiViewController?.navigationController?.pushViewController(scene, animated: false)
////            self.uiViewController?.present(scene, animated: false, completion:  nil)
//        }else {
//            self.uiViewController?.present(scene, animated: false, completion:  nil)
////            UIApplication.shared.keyWindow?.rootViewController?.present(scene, animated: false, completion:  nil)
//        }
//
//    }
//
//    func errorMessage(errorMessage: String, errorType: String, tabName: String) -> Void {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let scene: ErrorViewController = storyboard.instantiateViewController(withIdentifier: "ErrorMessageViewController") as! ErrorViewController
//        scene.setErrorMessage(message: errorMessage)
//        if tabName == "Home" {
//            scene.setGoToHomeTab(goToHomeTab: true)
//        }
//        //self.uiViewController?.performSegue(withIdentifier: identifier, sender: self.uiViewController)
////         self.uiViewController?.present(scene, animated: false, completion:  nil)
//        self.uiViewController?.navigationController?.pushViewController(scene, animated: false)
//
//    }
//
//    func errorMessage(errorMessage: String, errorType: String) -> Void {
//        DispatchQueue.main.async {
//
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let scene: ErrorViewController = storyboard.instantiateViewController(withIdentifier: "ErrorMessageViewController") as! ErrorViewController
//            scene.setErrorMessage(message: errorMessage)
//                self.uiViewController?.present(scene, animated: false, completion:  nil)
//
//        }
//    }
}
