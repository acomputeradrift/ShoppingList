//
//  ViewController.swift
//  ShoppingList
//
//  Created by Jamie on 2018-08-22.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit




class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var itemUITableView: UITableView!



    var demoData = DemoData()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.itemUITableView.setEditing(true, animated: true)
        self.itemUITableView.allowsMultipleSelectionDuringEditing = false;


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let demoData = DemoData()
        return demoData.currentItemsArray.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        cell.amountUILabel.text = "\(demoData.currentItemsArray[indexPath.row].amount)"
        cell.itemUILabel.text = demoData.currentItemsArray[indexPath.row].title
                return cell
    }


    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
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
}
