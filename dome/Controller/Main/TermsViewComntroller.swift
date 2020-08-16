//
//  TermsViewComntroller.swift
//  iPay
//
//  Created by Navoda on 12/2/19.
//  Copyright © 2019 iPay. All rights reserved.
//

import UIKit

class TermsViewComntroller: CustomRootViewController {
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "terms", ofType: "html")!) as URL) as URLRequest)
    }
    
    @IBAction func backClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
