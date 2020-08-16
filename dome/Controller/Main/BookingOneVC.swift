//
//  BookingOneVC.swift
//  Dome
//
//  Created by Thushara Wijekoon on 8/16/20.
//  Copyright © 2020 iPay. All rights reserved.
//

import UIKit

class BookingOneVC: CustomRootViewController {
   
   override func viewDidLoad() {
       super.viewDidLoad()
   }
    
    @IBAction func goBack(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickMenu(_ sender: Any) {
           gotoMenu()
       }
    
    @IBAction func clickAirDome(_ sender: Any) {
//        performSegue(withIdentifier: "loc2_to_reserve", sender: nil)
    }
    
    @IBAction func clickOutDoor(_ sender: Any) {
    }
    
    @IBAction func clickNext(_ sender: Any) {
        performSegue(withIdentifier: "book_one_to_two", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "loc2_to_reserve"{
//            if segue.destination is CreateLoanController{
//                let vc = segue.destination as! CreateLoanController
//    //            vc.loanTypeId = loanItem.id
//            }
        }
}
