//
//  CustomViewController.swift
//  iPay
//
//  Created by Sinnathamby Shanmugarajah on 3/27/17.
//  Copyright © 2017 iPay. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let backImage = UIImage(named: "back-icon")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 55/255, blue: 125/255, alpha: 1)
        
//        let customFont = UIFont(name: "Thejanee", size: 20)
//        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : customFont!,NSForegroundColorAttributeName : UIColor.white]
        
        self.navigationItem.titleView?.tintColor = UIColor.white
        
        
        // Do any additional setup after loading the view.
    }
    
  /*  override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    } */

    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
