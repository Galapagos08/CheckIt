//
//  ListDetailViewController.swift
//  CheckIt
//
//  Created by Dan Esrey on 2016/08/11.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController {

    var list: List!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(list.listName)"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.listItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListItemCell
        let listItems = list.listItems
        let listItem = listItems[indexPath.row]
        cell.itemInfoLabel.text = listItem.itemInfo
        displayCheckedStatus(cell, withListItem: listItem)
        return cell
    }
 
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ListItemCell
        let listItems = list.listItems
        let listItem = listItems[indexPath.row]
        listItem.toggleChecked()
        displayCheckedStatus(cell, withListItem: listItem)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func displayCheckedStatus(_ cell: ListItemCell, withListItem item: ListItem) {
        if item.checked {
            cell.checkedLabel.text = "✓"
        } else {
            cell.checkedLabel.text = ""
        }
    }
 
    @IBAction func resetChecks(_ sender: UIBarButtonItem) {
        let listItems = list.listItems
        for listItem in listItems {
            listItem.checked = false
            tableView.reloadData()
        }
    }
    
 }
