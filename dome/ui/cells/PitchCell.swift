//
//  PitchCell.swift
//  Dome
//
//  Created by Thushara Wijekoon on 8/16/20.
//  Copyright © 2020 iPay. All rights reserved.
//

import UIKit

class PitchCell: UITableViewCell {

    @IBOutlet weak var lblName: IpayLabel!
    @IBOutlet weak var lblMaxPlayers: IpayLabel!
    @IBOutlet weak var btnImage: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
