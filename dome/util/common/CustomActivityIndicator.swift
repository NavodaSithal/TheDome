//
//  CustomActivityIndicator.swift
//  iPay
//
//  Created by Chandana Pathirage on 7/10/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import UIKit

class CustomActivityIndicator: NSObject {

    var activityIndicator:UIActivityIndicatorView!
    let loadingView: UIView!
    var screenSize: CGRect!
    var count : Int = 0
    
    override init() {
        activityIndicator = UIActivityIndicatorView()
        loadingView = UIView()
        screenSize = UIScreen.main.bounds
    }
    
    func start(view: UIView) {
        count += 1
        loadingView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        loadingView.clipsToBounds = true
            
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.isHidden = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x:loadingView.frame.size.width / 2,y:loadingView.frame.size.height / 2);
            
        loadingView.addSubview(activityIndicator)
        view.addSubview(loadingView)
        loadingView.isHidden = false
            
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stop() {
        count -= 1
        print(count)
        if count <= 0 && activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
            loadingView.isHidden = true
        }
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
