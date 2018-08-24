//
//  ViewController.swift
//  ShoppingList
//
//  Created by Jamie on 2018-08-22.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class ViewController:
  UIViewController,
  UITableViewDelegate,
  UITableViewDataSource,
  AddObjectViewControllerDelgate
{
  
  var myAddVC: AddObjectViewController?
  
  @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var itemUITableView: UITableView!
  @IBOutlet weak var editUIButton: UIButton!
  var demoData = DemoData()
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    self.itemUITableView.allowsMultipleSelectionDuringEditing = false;
    NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  func itemAdded(sentItem: ListItem)
  {
    //                print("THIS: \(sentItem.title)")
    //                print("THIS: \(sentItem.amount)")
    demoData.currentItemsArray.append(sentItem)
    itemUITableView.reloadData()
    //                    for anyItem in demoData.currentItemsArray
    //                    {
    //                        print ("\(anyItem.title)")
    //                    }
  }
  
  //MARK: - Swipe Up
  
  @objc func keyboardWillShow (){
    //            print("keyboard is on its way!")
    tappedAdditem()
  }
  @objc func keyboardWillHide (){
    //            print("keyboard is outta here!")
  }
  
  func tappedAdditem(){
    //bottomConstraint
    let newConstant :CGFloat
    if bottomConstraint.constant == -250{
      newConstant = 0
      
    }else{
      newConstant = -250
      
    }
    DispatchQueue.main.async {[unowned self] in
      UIView.animate(withDuration: 0.2, animations: {
        self.bottomConstraint.constant = newConstant
        self.view.layoutIfNeeded()
      })
    }     
  
  }
  
  //  MARK: - TableView Setup
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return demoData.currentItemsArray.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
    let thisItem = demoData.currentItemsArray[indexPath.row]
    
    cell.amountUILabel.text = "\(thisItem.amount)"
    cell.itemUILabel.text = thisItem.title
    if (thisItem.status) // active
    {
      cell.itemUILabel.textColor = UIColor .lightGray
      cell.amountUILabel.textColor = UIColor .lightGray
    }
    else
    {
      cell.itemUILabel.textColor = UIColor .black
      cell.amountUILabel.textColor = UIColor .black
    }
    return cell
    
  }
  //   where cell is interacted with to mark item done or undone/ will also call sort method, then reload table data
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath)
  {
    
    demoData.currentItemsArray[indexPath.row].status = !demoData.currentItemsArray[indexPath.row].status
    demoData.sortEntireList()
    itemUITableView .reloadData()
    
  }
  
  //  MARK: - Clear All and Delete/Edit Item
  
  @IBAction func showEditing(_ sender: UIButton)
  {
    if(self.itemUITableView.isEditing == true)
    {
      self.itemUITableView.setEditing(false, animated: true)
      self.editUIButton.setTitle("Edit", for: .normal)
    }
    else
    {
      self.itemUITableView.setEditing(true, animated: true)
      self.editUIButton.setTitle("Done", for: .normal)
    }
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if (editingStyle == UITableViewCellEditingStyle.delete) {
      //       handle delete (by removing the data from your array and updating the tableview)
      demoData.removeListItem(itemNumber: indexPath.row)
      tableView.deleteRows(at: [indexPath],
                           with: UITableViewRowAnimation.top)
    }
  }
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let movedObject = demoData.currentItemsArray[sourceIndexPath.row]
    demoData.currentItemsArray.remove(at: sourceIndexPath.row)
    demoData.currentItemsArray.insert(movedObject, at: destinationIndexPath.row)
  }
  
  @IBAction func clearItemList(_ sender: UIButton) {
    demoData.currentItemsArray.removeAll()
    itemUITableView.reloadData()
  }
  
  //  MARK: - Segue
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if (segue.identifier == "toAddObjectViewController")
    {
      myAddVC = (segue.destination as! AddObjectViewController)
      myAddVC!.delegate = self
    }
  }
}



