//
//  BookingFiveVC.swift
//  Dome
//
//  Created by Thushara Wijekoon on 8/17/20.
//  Copyright © 2020 iPay. All rights reserved.
//

import Foundation
import UIKit

class BookingFiveVC: CustomRootViewController {
    
    @IBOutlet weak var lblTerms: UILabel!
    @IBOutlet weak var tblPitches: UITableView!
    var merchantList : [Pitch] = []
    var termsText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTermsText()
//        let obj = Pitch()
//        obj.name = "test"
//        obj.desc = "sdf"
//        obj.maxPlaers = 20
//        obj.image = "https://internetgovernancehub.blog/wp-content/uploads/2019/05/google.jpg"
//        merchantList.append(obj)
//        tblPitches.reloadData()
    }
    
    func setTermsText(){
        termsText = "\(getLocalizedString(key: "i_have_read_accept_the")) \(getLocalizedString(key: "terms_conditions")) \(getLocalizedString(key: "and")) \(getLocalizedString(key: "release_agreement")) "
        lblTerms.text = termsText
        self.lblTerms.textColor =  UIColor(hexString: "#4A4A4A")
        let underlineAttriString = NSMutableAttributedString(string: termsText)
        let range1 = (termsText as NSString).range(of: getLocalizedString(key: "terms_conditions"))
        let range2 = (termsText as NSString).range(of: getLocalizedString(key: "release_agreement"))
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hexString: "#F57129"), range: range1)
         underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hexString: "#F57129"), range: range2)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5  
        underlineAttriString.addAttribute(.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, underlineAttriString.length))
        lblTerms.attributedText = underlineAttriString
        lblTerms.isUserInteractionEnabled = true
        lblTerms.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
    }
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
       let termsRange = (termsText as NSString).range(of: getLocalizedString(key: "terms_conditions"))
       // comment for now
       let agrementRange = (termsText as NSString).range(of: getLocalizedString(key: "release_agreement"))

       if gesture.didTapAttributedTextInLabel(label: lblTerms, inRange: termsRange) {
           print("Tapped terms")
       } else if gesture.didTapAttributedTextInLabel(label: lblTerms, inRange: agrementRange) {
           print("Tapped privacy")
       } else {
           print("Tapped none")
       }
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

extension BookingFiveVC : UITableViewDelegate , UITableViewDataSource {
    
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

extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                              //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)

        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
                                                        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }

}
