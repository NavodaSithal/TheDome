//
//  customUiSlider.swift
//  iPay
//
//  Created by Navoda on 10/3/18.
//  Copyright © 2018 iPay. All rights reserved.
//

import UIKit

class customUiSlider: UISlider {

    var label: UILabel
    var labelXMin: CGFloat?
    var labelXMax: CGFloat?
    var labelText: ()->String = { "" }
    
    required public init?(coder aDecoder: NSCoder) {
        label = UILabel()
        label.textColor = UIColor(hexString: "53AFC6")
        super.init(coder: aDecoder)
        self.addTarget(self, action: #selector(onValueChanged) , for: .valueChanged)
        
    }
    func setup(){
        labelXMin = frame.origin.x + 10
        labelXMax = frame.origin.x + self.frame.width - 15
        let labelXOffset: CGFloat = labelXMax! - labelXMin!
        let valueOffset: CGFloat = CGFloat(self.maximumValue - self.minimumValue)
        let valueDifference: CGFloat = CGFloat(self.value - self.minimumValue)
        let valueRatio: CGFloat = CGFloat(valueDifference/valueOffset)
        let labelXPos = CGFloat(labelXOffset*valueRatio + labelXMin!)
        label.frame = CGRect(x: labelXPos, y: self.frame.origin.y - 20, width: 200, height: 20)
        label.text = self.value.description
        label.font = UIFont.systemFont(ofSize: 12)
        self.superview!.addSubview(label)
        
    }
    func updateLabel(){
        label.text = labelText()
        let labelXOffset: CGFloat = labelXMax! - labelXMin!
        let valueOffset: CGFloat = CGFloat(self.maximumValue - self.minimumValue)
        let valueDifference: CGFloat = CGFloat(self.value - self.minimumValue)
        let valueRatio: CGFloat = CGFloat(valueDifference/valueOffset)
        let labelXPos = CGFloat(labelXOffset*valueRatio + labelXMin!)
        label.frame = CGRect(x: labelXPos - label.frame.width/2, y: self.frame.origin.y - 20, width: 200, height: 20)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 12)
        
        self.superview!.addSubview(label)
    }
    
    public override func layoutSubviews() {
        labelText = { self.value.description }
        setup()
        updateLabel()
        super.layoutSubviews()
    }
    
    @objc func onValueChanged(sender: customUiSlider){
        updateLabel()
    }
    
}
