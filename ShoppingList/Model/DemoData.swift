//
//  demoData.swift
//  ShoppingList
//
//  Created by Nathan Wainwright on 2018-08-22.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class DemoData: NSObject {
  var firstTask = ListItem(title: "Apples", andAmount: 5)
  var secondTask = ListItem(title: "Oranges", andAmount: 1)
  var thirdTask = ListItem(title: "Milk 2% 4L", andAmount: 1)
  var fourthTask = ListItem(title: "Can of Black Paint", andAmount: 15)
  var fifthTask = ListItem(title: "Shiny New Car", andAmount: 1)
  var demoData: [ListItem]
  
  override init() {
    demoData = [firstTask, secondTask, thirdTask, fourthTask, fifthTask]
    super.init()
  }
  
  func addListItem(titleString: String, newNumber: Int) {
    demoData.append(ListItem(title: titleString, andAmount: Int32(newNumber)))
  }
  
  func removeListItem(itemNumber: Int) {
    demoData.remove(at: itemNumber)
  }
  
  
  
  
  
  
  
  
  
//  DELETE ONCE TESTED -- DROP INTO VIEW CONTROLLER FOR TESTING
//  actualTest.addListItem(titleString: "HELLO", newNumber: 45)
//
//  for item in actualTest.demoData {
//  print(item.title)
//  }
//   STOP DELETEING HERE -- DROP INTO VIEW CONTROLLER FOR TESTING
  
  
  
  
  
  
  
  
  
  
  
//  var demoDataArray:[taskItem] = [firstTask, secondTask, thirdTask, fourthTask, fifthTask]
  
//  var date: Date
//  var now = Date()
//  var dates: [Date]
//  var dates = [Date]()
//  var dates: [Date] = []
  
  
  //= [firstTask, secondTask, thirdTask, fourthTask, fifthTask]
  
  
  
  
  
  //point of this class is to init data for the demo of the app
  
  // properties needed:
  //      array of taskItem objects

}
