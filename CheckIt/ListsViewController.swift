//
//  ListsViewController.swift
//  CheckIt
//
//  Created by Dan Esrey on 2016/07/11.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class ListsViewController: UITableViewController {

    var listStore: ListStore!
    var lists: [List] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Checklists"
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        let list = lists[indexPath.row]
        cell.listNameLabel.text = list.listName
        return cell
    }
    
    @IBAction func toggleEditingMode(_ sender: AnyObject) {
        if isEditing {
            sender.setTitle("Edit", for: UIControlState())
            setEditing(false, animated: true)
        }
        else {
            sender.setTitle("Done", for: UIControlState())
            setEditing(true, animated: true)
        }
    }
    
   
}

