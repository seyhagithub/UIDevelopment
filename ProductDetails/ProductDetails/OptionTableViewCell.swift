//
//  OptionTableViewCell.swift
//  ProductDetails
//
//  Created by Hiem Seyha on 5/29/17.
//  Copyright © 2017 seyha. All rights reserved.
//


// Delegate Picker View
protocol OptionalProtocol {
  
  func getColor(color:String)
  func getGender(gender:String)
}

import UIKit

class OptionTableViewCell: UITableViewCell {
  
  let colorPickerView = UIPickerView()
  let genderPickerView = UIPickerView()
  var optionalDelegate: ViewController?
  
  @IBOutlet weak var colorTextField: UITextField!
  @IBOutlet weak var genderTextField: UITextField!

  func configureCell(parentObject: ViewController) {
    
    colorPickerView.delegate = parentObject
    colorPickerView.dataSource = parentObject
    colorPickerView.tag = 0
    colorTextField.inputView = colorPickerView
    
    genderPickerView.delegate = parentObject
    genderPickerView.dataSource = parentObject
    genderPickerView.tag = 1
    genderTextField.inputView = genderPickerView
    
    customPicker(textField: genderTextField)
    customPicker(textField: colorTextField)
    
  }

  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    if textField == colorTextField || textField == genderTextField {
      
      return false
    }
    return true
  }
  
  func customPicker(textField: UITextField){
    
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
    
    let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(ChooseDoneAction))
    done.tintColor = UIColor.gray
    
    toolbar.setItems([done], animated: false)
    
    textField.inputAccessoryView = toolbar
  
  }
  
  
  
  func ChooseDoneAction() {
    self.endEditing(true)
    
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


extension OptionTableViewCell {
  
  func getColor(color: String) {
    switch color {
    case "White":
      self.colorTextField.backgroundColor = UIColor.white
    case "Black":
      self.colorTextField.backgroundColor = UIColor.black
    case "Red":
      self.colorTextField.backgroundColor = UIColor.red
    default:
      break
    }
  }

  func getGender(gender: String) {
    
    genderTextField.text = gender
  }
  
}

