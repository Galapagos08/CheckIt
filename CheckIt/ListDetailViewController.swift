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
        title = list.listName
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.listItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let listItems = list.listItems
        let listItem = listItems[indexPath.row]
        cell.textLabel!.text = listItem.itemInfo
        return cell
    }
 
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 
 }
