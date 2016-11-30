//
//  ListDetailViewController.swift
//  CheckIt
//
//  Created by Dan Esrey on 2016/08/11.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController, UITextFieldDelegate {
    
    var list: List!
    var listStore: ListStore!
    var listItemTextField: UITextField?
       
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(list.listName)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.register(UINib(nibName: "ChecklistItemCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.listItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChecklistItemCell
        listItemTextField = cell.itemInfoTextField
        let listItems = list.listItems
        let listItem = listItems[indexPath.row]
        cell.itemInfoTextField.text = listItem.itemInfo
        cell.itemInfoTextField.isEnabled = false
        displayCheckedStatus(cell, withListItem: listItem)
        cell.itemInfoTextField.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as!ChecklistItemCell
        let listItems = list.listItems
        let listItem = listItems[indexPath.row]
        listItem.toggleChecked()
        displayCheckedStatus(cell, withListItem: listItem)
        tableView.deselectRow(at: indexPath, animated: true)
        listStore.saveChanges()
    }
    
    func displayCheckedStatus(_ cell: ChecklistItemCell, withListItem item: ListItem) {
        if item.checked {
            cell.checkedLabel.text = "✓"
        } else {
            cell.checkedLabel.text = ""
        }
    }
    
    @IBAction func resetChecks(_ sender: UIBarButtonItem) {
        let listItems = list.listItems
        let title = "Reset \(list.listName)?"
        let message = "Are you sure you want to reset this list by unchecking all items?"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let resetAction = UIAlertAction(title: "Reset", style: .destructive, handler: { (action) -> Void in
            self.listStore.uncheckItems(listItems: listItems)
            self.tableView.reloadData()
            self.listStore.saveChanges()
        })
        alertController.addAction(resetAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
