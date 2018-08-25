//
//  ViewController.swift
//  ShoppingList
//
//  Created by Jamie on 2018-08-22.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit
import Realm

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
  var appData = AppData() 
//  var appData = AppData()
  var realmArray = [ListItem]()
  // need array property, mutable.
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    self.itemUITableView.allowsMultipleSelectionDuringEditing = false;
    //readNewItem()
    NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  
  
  func itemAdded(sentItem: ListItem)
  {
    //                print("THIS: \(sentItem.title)")
    //                print("THIS: \(sentItem.amount)")
    appData.currentItemsArray.append(sentItem)
    writeNewItem(addedItem: sentItem)
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
    if bottomConstraint.constant == -275{ //orig 250
      // IF THIS CHANGES AT ALL, YOU NEED TO CHANGE SPOT IN STORYBOARD AS WELL, containerview "bottom constraint" MUST match this number
      newConstant = 0
      
    }else{
      newConstant = -275 //orig 250; changed so that no 'empty' space below textfield
     // IF THIS CHANGES AT ALL, YOU NEED TO CHANGE SPOT IN STORYBOARD AS WELL, containerview "bottom constraint" MUST match this number
      
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
    return appData.currentItemsArray.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
    let thisItem = appData.currentItemsArray[indexPath.row]
    
    cell.amountUILabel.text = "\(thisItem.amount)"
    cell.itemUILabel.text = thisItem.title
    if (thisItem.isCompleted) // active
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
    
    appData.currentItemsArray[indexPath.row].isCompleted = !appData.currentItemsArray[indexPath.row].isCompleted
    appData.sortEntireList()
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
      appData.removeListItem(itemNumber: indexPath.row)
      tableView.deleteRows(at: [indexPath],
                           with: UITableViewRowAnimation.top)
    }
  }
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let movedObject = appData.currentItemsArray[sourceIndexPath.row]
    appData.currentItemsArray.remove(at: sourceIndexPath.row)
    appData.currentItemsArray.insert(movedObject, at: destinationIndexPath.row)
  }
  
  @IBAction func clearItemList(_ sender: UIButton) {
    appData.currentItemsArray.removeAll()
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
    
  //  MARK: - Realm Functions
    
    func writeNewItem(addedItem: ListItem) //need to bring in ListItem object
    {
        let newItem = ListItem ()
        newItem.title = addedItem.title
        newItem.amount = addedItem.amount
        //newItem.priority = addedItem.priority
        let realm = RLMRealm.default()
        realm.beginWriteTransaction()
        realm.add(newItem)
        do
        {
            try realm.commitWriteTransactionWithoutNotifying([])
        }
        catch let error
        {
            print("\(error)")
        }
        
    }

}



