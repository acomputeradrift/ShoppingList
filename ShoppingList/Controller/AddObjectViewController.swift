//
//  AddObjectViewController.swift
//  ShoppingList
//
//  Created by Jamie on 2018-08-22.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class AddObjectViewController: UIViewController, UITextFieldDelegate
{
  // OUTLETS HERE / AND OR PROPERTIES
  weak var delegate: AddObjectViewControllerDelgate?
  @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
  
  //  var itemToPassBack = ListItem()
  // Swift
  @IBOutlet weak var amountOfItemsLabel: UILabel!
  @IBOutlet weak var titleOfItemField: UITextField!
  
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var subButton: UIButton!
  
  var amount: Int = 0
  
  /// END
  override func viewDidLoad()
  {
    super.viewDidLoad()
    tapGestureRecognizer.addTarget(self, action: #selector(bottomsUp))
    amountOfItemsLabel.text = "\(amount)"
    titleOfItemField.placeholder = "Enter the item"
  }
  
  @objc func bottomsUp (){
    delegate?.tappedAdditem()
    //        print("yup it works")
  }
  /*
   // MARK: - Navigation
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  @IBAction func addSubAction(_ sender: Any)
  {
    if ( (sender as! UIButton) == addButton)
    {
      amount += 1
    }
    else
    {
      if ( amount > 0)
      {
        amount -= 1
      }
    }
    amountOfItemsLabel.text = "\(amount)"
  }
  
  @IBAction func clearTitleTextButtonPressed(_ sender: Any)
  {
    titleOfItemField.text = ""
    amountOfItemsLabel.text = "0"
    amount = 0
    //    print("CLEAR BUTTON PRESSED")
  }
  ////  keep if we add stepper to UI
  //  @IBAction func stepperChanged(_ sender: Any)
  //  {
  //    amount = Int((sender as! UIStepper).value)
  //  }
  
  //  START BLOCK -- CHARACTER LIMIT
  let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_"
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
    let filtered = string.components(separatedBy: cs).joined(separator: "")
    
    return (string == filtered)
  }
  //  END BLOCK -- CHARACTER LIMIT
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  {
    textField.resignFirstResponder()
    //    let tempAmount = Int(amountOfItemsField.text!)
    
    //GUARD STATEMENT TO PREVENT BLANK ENTRIES
    // if text from textfield IS empty; return false
    // if not, grab information, put into 'itemToPassBack', then return true.
    guard let text = titleOfItemField.text, !text.isEmpty else {
      return false
    }
    //END GUARD STATEMENT -- does rest if it's not empty
    
    let itemToPassBack = ListItem()
    
    itemToPassBack.title = titleOfItemField.text!
    itemToPassBack.amount = Int32(amount)
    
    self.delegate?.itemAdded(sentItem: itemToPassBack)
    
    //  CLEARS TEXTFIELD/AMOUNTLABEL WHEN ITEM SENT
    titleOfItemField.text = ""
    amountOfItemsLabel.text = "0"
    amount = 0
    //    END CLEAR
    
    // print("ENTER PRESSED")
    return true
  }
}
