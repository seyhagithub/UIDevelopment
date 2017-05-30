//
//  ListMotorTableViewCell.swift
//  ProductDetails
//
//  Created by Hiem Seyha on 5/29/17.
//  Copyright © 2017 seyha. All rights reserved.
//

import UIKit

class ListMotorTableViewCell: UITableViewCell {

  @IBOutlet weak var listCollectionView: UICollectionView!
  
  func configureCell(parentObject: ViewController) {
    
    listCollectionView.delegate = parentObject
    listCollectionView.dataSource = parentObject
    
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

