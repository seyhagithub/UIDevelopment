//
//  ViewController.swift
//  ScrollViewPage
//
//  Created by Brian Advent on 02/12/2016.
//  Copyright © 2016 Brian Advent. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var featureScrollView: UIScrollView!
    @IBOutlet weak var featurePageControl: UIPageControl!
    
    let feature1 = ["title":"Apple Watch","price":"$0.99","image":"1"]
    let feature2 = ["title":"More Designs","price":"$1.99","image":"2"]
    let feature3 = ["title":"Notifications","price":"$0.99","image":"3"]
    
    var featureArray = [Dictionary<String,String>]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        featureArray = [feature1,feature2,feature3]
       
        featureScrollView.isPagingEnabled = true
        featureScrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(featureArray.count), height: 250)
        featureScrollView.showsHorizontalScrollIndicator = false
        featureScrollView.showsVerticalScrollIndicator = false
        
        featureScrollView.delegate = self
      
        loadFeatures()
      
      Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)

      
      
    }
  
  func moveToNextPage (){
    
    let pageWidth:CGFloat = self.featureScrollView.frame.width
    
    print("scrollview with", featureScrollView.frame.width)
    
    let maxWidth:CGFloat = pageWidth * 3
    let contentOffset:CGFloat = self.featureScrollView.contentOffset.x
    
    var slideToX = contentOffset + pageWidth
    
    if  contentOffset + pageWidth == maxWidth
    {
      slideToX = 0
    }
    
//    UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: [.transitionFlipFromRight, .curveEaseIn], animations: {
//      
//       self.featureScrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.featureScrollView.frame.height), animated: false)
//      
//    }, completion: nil)
    
     self.featureScrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.featureScrollView.frame.height), animated: true)
   
  }
    
    
    func loadFeatures() {
        
        for (index, feature) in featureArray.enumerated() {
          
            if let featureView = Bundle.main.loadNibNamed("Feature", owner: self, options: nil)?.first as? FeatureView {
                featureView.featureImageView.image = UIImage(named: feature["image"]!)
                featureView.titleLabel.text = feature["title"]
                featureView.priceLabel.text = feature["price"]
                
                featureView.purchaseButton.tag = index
                featureView.purchaseButton.addTarget(self, action: #selector(ViewController.buyFeature(sender:)), for: .touchUpInside)
                
                featureScrollView.addSubview(featureView)
                featureView.frame.size.width = self.view.bounds.size.width
                featureView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
                
            }
        
        }
        
        
    }
    
    func buyFeature (sender:UIButton) {
        print("The user wants to buy feature \(sender.tag)")
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        print(scrollView.contentOffset.x)
        featurePageControl.currentPage = Int(page)
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
    
    
    
  }


}

