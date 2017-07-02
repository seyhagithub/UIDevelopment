//
//  MotorTableViewCell.swift
//  ProductDetails
//
//  Created by Hiem Seyha on 5/29/17.
//  Copyright © 2017 seyha. All rights reserved.
//

import UIKit



//class MyCollectionViewCell:UICollectionViewCell {
//    
//    let image: UIImageView = {
//        let myImage = UIImageView()
//        myImage.translatesAutoresizingMaskIntoConstraints = false
//        return myImage
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        addSubview(image)
//        
//        image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
//        image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
//        image.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
//        image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}

class MotorTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  @IBOutlet weak var motorScrollView: UIScrollView!
  @IBOutlet weak var motorImageView: UIImageView!
    
    var listImage:[UIImage] = []
    
    var collectionView:UICollectionView?
  
    override func awakeFromNib() {
        super.awakeFromNib()
//      self.motorScrollView.minimumZoomScale = 1.0
//      self.motorScrollView.maximumZoomScale = 6.0
//      self.motorScrollView.delegate = self
        
        
      
//      motorImageView.isUserInteractionEnabled = true
//      let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.doubleTap))
//      doubleTap.numberOfTapsRequired = 2
//      motorImageView.addGestureRecognizer(doubleTap)
        
        
       
    }
    
    func configureCell() {
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView?.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.backgroundColor = UIColor.white
        self.addSubview(collectionView!)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("numberOfItemsInSection")
        return listImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("UICollectionViewCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.image.image = listImage[indexPath.row]
        cell.backgroundColor = UIColor.red
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 300)
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
