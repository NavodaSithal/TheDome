//
//  DateCell.swift
//  Dome
//
//  Created by Thushara Wijekoon on 8/16/20.
//  Copyright © 2020 iPay. All rights reserved.
//


import UIKit

class DateCell: UITableViewCell {

    @IBOutlet weak var lblTime: IpayLabel!
    @IBOutlet weak var lblStatus: IpayLabel!
    @IBOutlet weak var btnCb: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
