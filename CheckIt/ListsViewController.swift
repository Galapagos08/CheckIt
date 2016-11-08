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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listStore.allLists.count
    }

}

