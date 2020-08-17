//
//  BookingThreeVC.swift
//  Dome
//
//  Created by Thushara Wijekoon on 8/16/20.
//  Copyright © 2020 iPay. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class BookingThreeVC: CustomRootViewController {
    
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    
    var gender = ""
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
    
    @IBAction func btnMaleClick(_ sender: Any) {
        gender = "M"
      btnMale.setBackgroundImage(UIImage(named: "radio_active"), for: UIControlState.normal)
      btnFemale.setBackgroundImage(UIImage(named: "radio"), for: UIControlState.normal)

    }
    @IBAction func btnFemaleCLick(_ sender: Any) {
        gender = "F"
         btnFemale.setBackgroundImage(UIImage(named: "radio_active"), for: UIControlState.normal)
         btnMale.setBackgroundImage(UIImage(named: "radio"), for: UIControlState.normal)
    }
    
    @IBAction func clickAirDome(_ sender: Any) {
        //        performSegue(withIdentifier: "loc2_to_reserve", sender: nil)
    }
    
    @IBAction func clickOutDoor(_ sender: Any) {
    }
    
    @IBAction func clickNext(_ sender: Any) {
         performSegue(withIdentifier: "book_three_to_four", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if segue.identifier == "loc2_to_reserve"{
        //            if segue.destination is CreateLoanController{
        //                let vc = segue.destination as! CreateLoanController
        //    //            vc.loanTypeId = loanItem.id
        //            }
    }
}
