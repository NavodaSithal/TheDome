//
//  BookingTwoVC.swift
//  Dome
//
//  Created by Thushara Wijekoon on 8/16/20.
//  Copyright © 2020 iPay. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class BookingTwoVC: CustomRootViewController {
    
    @IBOutlet weak var tblPitches: UITableView!
    var merchantList : [Pitch] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let obj = Pitch()
        obj.name = "test"
        obj.desc = "sdf"
        obj.maxPlaers = 20
        obj.image = "https://internetgovernancehub.blog/wp-content/uploads/2019/05/google.jpg"
        merchantList.append(obj)
        tblPitches.reloadData()
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
         performSegue(withIdentifier: "book_two_to_three", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if segue.identifier == "loc2_to_reserve"{
        //            if segue.destination is CreateLoanController{
        //                let vc = segue.destination as! CreateLoanController
        //    //            vc.loanTypeId = loanItem.id
        //            }
    }
}

extension BookingTwoVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return merchantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item : Pitch = merchantList[indexPath.row]
        let cell = tblPitches.dequeueReusableCell(withIdentifier: "pitch_cell", for: indexPath) as! PitchCell
        cell.lblName.text = "\(item.name!) - \(item.desc!)"
        cell.lblMaxPlayers.text = "\(item.maxPlaers!)"
        let url = item.image
        cell.btnImage.sd_setImage(with: URL(string:url!),for: .normal)
        
        cell.btnImage.tag = indexPath.row
        cell.btnImage.addTarget(self, action: #selector(clickPitch(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showProducts", sender: self)
    }
    
    @objc func clickPitch(sender: UIButton){
        let  btnTag = sender.tag
        //        performSegue(withIdentifier: "ratingLoan", sender: self)
    }
    
}
