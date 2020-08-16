//
//  ShadowView.swift
//  iPay
//
//  Created by Navoda on 1/20/20.
//  Copyright © 2020 iPay. All rights reserved.
//

import UIKit
//@IBDesignable

class ShadowView: UIView {


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutView()
        
    }
    
    func layoutView() {
        let a = CGRect(x: self.bounds.origin.x+5, y: self.bounds.origin.y+5, width: self.bounds.width-10, height: self.bounds.height-7)
        self.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
//        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 6
        self.layer.shadowPath = UIBezierPath(rect: a).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        let a = CGRect(x: self.bounds.origin.x+5, y: self.bounds.origin.y+5, width: self.bounds.width-10, height: self.bounds.height-7)
        self.layer.shadowPath = UIBezierPath(rect: a).cgPath
    }
    
}
