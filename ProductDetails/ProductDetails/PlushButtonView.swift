//
//  PlushButtonView.swift
//  ProductDetails
//
//  Created by Hiem Seyha on 5/30/17.
//  Copyright © 2017 seyha. All rights reserved.
//

import UIKit

@IBDesignable
class PlushButtonView: UIButton {

  override func draw(_ rect: CGRect) {
    
    layer.cornerRadius = bounds.width / 2
    layer.borderWidth = 7
    layer.borderColor = UIColor.green.cgColor
    
    let hLine = UIBezierPath()
    hLine.lineWidth = 7
    hLine.move(to: CGPoint(x: bounds.height / 4, y: bounds.height / 2))
    hLine.addLine(to: CGPoint(x: bounds.height / 4 + 15, y: bounds.height / 2 + 20))
    hLine.lineCapStyle = .round
    UIColor.green.setStroke()
    hLine.stroke()
    
    let rLine = UIBezierPath()
    rLine.move(to: CGPoint(x: (bounds.height / 4) + 15 , y: bounds.height / 2 + 20))
    rLine.addLine(to: CGPoint(x: bounds.width - 30, y: 35))
    UIColor.green.setStroke()
    rLine.lineCapStyle = .round
    rLine.lineWidth = 7
    rLine.stroke()
  }

}
