//
//  ViewController.swift
//  ProductDetails
//
//  Created by Hiem Seyha on 5/29/17.
//  Copyright © 2017 seyha. All rights reserved.
//

import UIKit

// Configuration Cell
let motorCell = "SliderCell"
let listMotorCell = "listMotorCell"
let titleCell = "TitleTableViewCell"
let optionCell = "OptionTableViewCell"
let descCell = "DescriptionTableViewCell"
let motorCCell = "motorCCell"

class ViewController: UIViewController {
    
    @IBOutlet weak var detailTableView: UITableView!
    
    //Table View Property
    let cells = [motorCell, listMotorCell, titleCell, optionCell, descCell]
    let listMotors = [#imageLiteral(resourceName: "motor"),#imageLiteral(resourceName: "motor"),#imageLiteral(resourceName: "motor1"),#imageLiteral(resourceName: "motor"),#imageLiteral(resourceName: "motor"),#imageLiteral(resourceName: "motor"),#imageLiteral(resourceName: "motor")]
    var optionalTVC:OptionTableViewCell?
    var motorCel:SlideImageTableViewCell?
    var listMotorTableViewCell:ListMotorTableViewCell?
    
    // Picker View
    
    let colorString = ["White", "Black", "Red"]
    let gender = ["Female", "Male"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Table View Configuration
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.scrollToVisibleCollectionView(_:)), name: NSNotification.Name(rawValue: "scrollActiveCV"), object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cells[indexPath.row] {
        case motorCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: motorCell, for: indexPath) as! SlideImageTableViewCell
            motorCel = cell
            cell.listImage = listMotors
            cell.configureCell()
            return cell
            
        case listMotorCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: listMotorCell, for: indexPath) as! ListMotorTableViewCell
            listMotorTableViewCell = cell
            cell.configureCell(parentObject: self)
            return cell
            
        case titleCell:
            let cell = Bundle.main.loadNibNamed(titleCell, owner: self, options: nil)?.first as! TitleTableViewCell
            
            return cell
            
        case optionCell:
            let cell = Bundle.main.loadNibNamed(optionCell, owner: self, options: nil)?.first as! OptionTableViewCell
            optionalTVC = cell
            cell.configureCell(parentObject: self)
            
            return cell
            
        case descCell:
            let cell = Bundle.main.loadNibNamed(descCell, owner: self, options: nil)?.first as! DescriptionTableViewCell
            
            return cell
            
        default:
            
            return UITableViewCell()
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch cells[indexPath.row] {
        case motorCell:
            return 250.0
            
        case listMotorCell:
            return 100.0
            
        case titleCell:
            return 100
            
        case optionCell:
            return 50.0
            
        case descCell:
            return 250.0
        default:
            return 0.0
        }
    }
}

// Collection View
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return listMotors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: motorCCell, for: indexPath) as! ListMotorCollectionViewCell
        cell.motorContenImageView.image = listMotors[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width / 4, height: view.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexPathScroll = IndexPath(row: indexPath.row, section: 0)
        motorCel?.collectionView?.scrollToItem(at: indexPathScroll, at: .left, animated: true)
        motorCel?.pageControl.currentPage = indexPath.row
    }
    
    func scrollToVisibleCollectionView(_ notification: NSNotification) {
      
        if let index = notification.object as? Int {
          
          let indexPath = IndexPath(row: index, section: 0)
          listMotorTableViewCell?.listCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }

    }
}

// Picker View

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 0 {
            
            return colorString.count
        }
        
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 0 {
            
            return colorString[row]
        }
        
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        
        if pickerView.tag == 0 {
            
            self.optionalTVC?.getColor(color: colorString[row])
            
        } else {
            
            self.optionalTVC?.getGender(gender: gender[row])
        }
    }
    
}
