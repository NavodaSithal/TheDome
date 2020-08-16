//
//  MenuVc.swift
//  Dome
//
//  Created by Thushara Wijekoon on 8/16/20.
//  Copyright © 2020 iPay. All rights reserved.
//

import Foundation
class MenuVc: CustomRootViewController {
    
    var gender = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func clickDashboard(_ sender: Any) {
    }
    
    @IBAction func clickBookings(_ sender: Any) {
    }
    @IBAction func clickInvoices(_ sender: Any) {
    }
    @IBAction func cilckCusSup(_ sender: Any) {
    }
    @IBAction func clickallery(_ sender: Any) {
    }
    @IBAction func clicklogout(_ sender: Any) {
    }
}
