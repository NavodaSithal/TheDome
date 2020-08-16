//
//  CommonSettingsCell.swift
//  iPay
//
//  Created by Navoda on 12/2/19.
//  Copyright © 2019 iPay. All rights reserved.
//

import UIKit

class CommonSettingsCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func setupView(){
        addSubview(imgView)
        addSubview(lblCategoryName)
        addSubview(imgArrow)
            
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[v0]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imgView]))
            
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : lblCategoryName]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[v0(20)]-40-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : imgArrow]))
            
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0(50)]-20-[v1]-10-[v2(20)]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : imgView, "v1":lblCategoryName, "v2": imgArrow]))
    }
        
    let imgView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "catloading")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
        
    let lblCategoryName : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "ProximaNovaCond-Regular", size: 17)
        lbl.numberOfLines = 2
        lbl.text = "testinggg"
        lbl.textColor = UIColor(hexString: "#1B466D")
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
        
    let imgArrow : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "right_arrow")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
}
