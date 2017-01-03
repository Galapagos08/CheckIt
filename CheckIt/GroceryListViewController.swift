//
//  GroceryListViewController.swift
//  CheckIt
//
//  Created by Dan Esrey on 2016/12/12.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class GroceryListViewController: UITableViewController, UITextFieldDelegate {

    var listStore: ListStore!
    var listTemplate = GroceryLists()
    var newListItems: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.register(UINib(nibName: "ChecklistItemCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return listTemplate.dairyList.count
        case 1:
            return listTemplate.fruitList.count
        case 2:
            return listTemplate.meatList.count
        case 3:
            return listTemplate.vegList.count
        default:
            fatalError("Unexpected grocery section")
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Dairy"
        case 1:
            return "Fruit"
        case 2:
            return "Meats"
        case 3:
            return "Vegetables"
        default:
            fatalError("unexpected section")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChecklistItemCell
        switch indexPath.section {
        case 0:
            cell.itemInfoTextField.text = listTemplate.dairyList[indexPath.row]
        case 1:
            cell.itemInfoTextField.text = listTemplate.fruitList[indexPath.row]
        case 2:
            cell.itemInfoTextField.text = listTemplate.meatList[indexPath.row]
        case 3:
            cell.itemInfoTextField.text = listTemplate.vegList[indexPath.row]
        default:
            fatalError("Unexpected section")
        }
        cell.itemInfoTextField.isEnabled = false
        return cell
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ChecklistItemCell
        if cell.checkedLabel.text == "" {
        let newListItem = cell.itemInfoTextField.text
        newListItems.append(newListItem!)
        cell.checkedLabel.text = "✓"
        } else if cell.checkedLabel.text == "✓" {
            newListItems.remove(at: indexPath.row)
            cell.checkedLabel.text = ""
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
        
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        listStore.createList(listName: "Groceries")
        let list = listStore.allLists.last!
        let listItems = listStore.convertStringArray(someArray: newListItems)
        list.listItems = listItems
        self.dismiss(animated: true, completion: nil)
    }
    
}
