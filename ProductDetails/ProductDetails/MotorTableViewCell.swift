//
//  MotorTableViewCell.swift
//  ProductDetails
//
//  Created by Hiem Seyha on 5/29/17.
//  Copyright © 2017 seyha. All rights reserved.
//

import UIKit

class MotorTableViewCell: UITableViewCell {

  @IBOutlet weak var motorScrollView: UIScrollView!
  @IBOutlet weak var motorImageView: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
      self.motorScrollView.minimumZoomScale = 1.0
      self.motorScrollView.maximumZoomScale = 6.0
      self.motorScrollView.delegate = self
      
      motorImageView.isUserInteractionEnabled = true
      let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.doubleTap))
      doubleTap.numberOfTapsRequired = 2
      motorImageView.addGestureRecognizer(doubleTap)
    }


  func doubleTap() {
    
    if motorScrollView.zoomScale > 1.0 {
      
      motorScrollView.setZoomScale(1.0, animated: true)
      
    } else {
      
      motorScrollView.setZoomScale(2.0, animated: true)
    }
  }
    
}


extension MotorTableViewCell: UIScrollViewDelegate {
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return motorImageView
  }
}
