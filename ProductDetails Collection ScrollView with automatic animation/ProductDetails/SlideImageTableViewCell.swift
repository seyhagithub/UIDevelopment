//
//  SlideImageTableViewCell.swift
//  ProductDetails
//
//  Created by Hiem Seyha on 7/1/17.
//  Copyright © 2017 seyha. All rights reserved.
//

import UIKit

class MyCollectionViewCell:UICollectionViewCell , UIScrollViewDelegate{
  
  let image: UIImageView = {
    let myImage = UIImageView()
    myImage.translatesAutoresizingMaskIntoConstraints = false
    return myImage
  }()
  
  lazy var scrollView: UIScrollView = {
    let myScrollView = UIScrollView()
    myScrollView.translatesAutoresizingMaskIntoConstraints = false
    myScrollView.minimumZoomScale = 1.0
    myScrollView.backgroundColor = UIColor.white
    myScrollView.maximumZoomScale = 6.0
    myScrollView.showsHorizontalScrollIndicator = false
    myScrollView.showsVerticalScrollIndicator = false
    myScrollView.delegate = self
    return myScrollView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    print("add subview image")
    setupScrollView()
    setupImageView()
    
  
  }
  
  func setupScrollView() {
    
    addSubview(scrollView)
    
    scrollView.isUserInteractionEnabled = true
    let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.doubleTap))
    doubleTap.numberOfTapsRequired = 2
    scrollView.addGestureRecognizer(doubleTap)
    
    scrollView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
    scrollView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
    scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    
  }
  
  func setupImageView() {
    scrollView.addSubview(image)
    image.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
    image.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0).isActive = true
    image.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
    image.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
    image.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
    image.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: 0).isActive = true
   
  }
  
  func doubleTap() {
    
    if scrollView.zoomScale > 1.0 {
      
      scrollView.setZoomScale(1.0, animated: true)
      
    } else {
      
      scrollView.setZoomScale(2.0, animated: true)
    }
  }
  

    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
      return image
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

let cellID = "slideImageCell"

class SlideImageTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  var listImage:[UIImage] = []
  var collectionView:UICollectionView?
  var isRepeat = false
  
  var automacticalIndex = 0
  
  let  pageControl:UIPageControl = {
    let slider = UIPageControl(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
    slider.translatesAutoresizingMaskIntoConstraints = false
    slider.tintColor = UIColor.red
    slider.currentPageIndicatorTintColor = UIColor.green
    slider.pageIndicatorTintColor = UIColor.lightGray
    return slider
    
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  
  func configureCell() {
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    
    
    collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
    collectionView?.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
    
    collectionView?.backgroundColor = UIColor.white
    
    collectionView?.isPagingEnabled = true
    collectionView?.showsVerticalScrollIndicator = false
    collectionView?.showsHorizontalScrollIndicator = false
    
    collectionView?.delegate = self
    collectionView?.dataSource = self
    
    self.addSubview(collectionView!)
    
    setupPageControl()
    
    
    Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.atomaticalScrollImage), userInfo: nil, repeats: true)
    
  }
  
  func setupPageControl() {
    
    self.addSubview(pageControl)
    
    pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    pageControl.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0).isActive = true
    pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
    
    
    pageControl.currentPage = 0
    pageControl.numberOfPages = listImage.count
    
    print("setupPageControl", pageControl.frame)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    print("numberOfItemsInSection")
    return listImage.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    print("UICollectionViewCell")
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MyCollectionViewCell
    cell.image.image = listImage[indexPath.row]
    cell.backgroundColor = UIColor.red
    return cell
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: UIScreen.main.bounds.width, height: self.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
    let index = Int(scrollView.contentOffset.x / self.bounds.width)
    
    scrollImage(index:index)
  }
  
  func scrollImage(index:Int) {
    
    pageControl.currentPage = index

    NotificationCenter.default.post(name: NSNotification.Name(rawValue:"scrollActiveCV"), object: index, userInfo: nil)
  }
  
  func atomaticalScrollImage() {
    
    automacticalIndex += 1
    
    automacticalIndex = automacticalIndex < listImage.count ? automacticalIndex : 0
    
    let indexPath = IndexPath(row: automacticalIndex, section: 0)
    pageControl.currentPage = automacticalIndex
    collectionView?.scrollToItem(at: indexPath, at: .left, animated: true)
    
  }
  
}
