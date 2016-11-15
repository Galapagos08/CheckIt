//
//  ListsViewController.swift
//  CheckIt
//
//  Created by Dan Esrey on 2016/07/11.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class ListsViewController: UITableViewController {

    var listStore: ListStore = ListStore()
    var lists: [List] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Lists"
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "List Cell")
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        if listStore.allLists.count == 0 {
            return 0
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listStore.allLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "List Cell", for: indexPath) 
        let lists = listStore.allLists
        let list = lists[indexPath.row]
        cell.textLabel!.text = list.listName
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "List Detail" {
            if let row = (tableView.indexPathForSelectedRow as IndexPath?)?.row {
                let list = lists[row]
                let listDetailVC = segue.destination as! ListDetailViewController
                listDetailVC.list = list
            }
        }
    }
    
    @IBAction func addBarButton(_ sender: AnyObject){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navController = storyboard.instantiateViewController(withIdentifier: "Create List Nav") as! UINavigationController
        let createListVC = navController.topViewController as! CreateListViewController
        createListVC.listStore = listStore
        self.present(navController, animated: true, completion: nil)
    }
    
}

