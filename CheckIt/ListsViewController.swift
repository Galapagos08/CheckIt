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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    func cellForTableView(_ tableView: UITableView)-> UITableViewCell {
        let cellIdentifier = "List Cell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Lists"
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return listStore.allLists.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        let cell = cellForTableView(tableView)
        cell.accessoryType = .disclosureIndicator
        let lists = listStore.allLists
        let list = lists[indexPath.row]
        cell.textLabel!.text = list.listName
        cell.detailTextLabel?.text = "\(list.listItems.count) items"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListDetail" {
            if let row = (tableView.indexPathForSelectedRow)?.row {
                let list = listStore.allLists[row]
                let listDetailVC = segue.destination as! ListDetailViewController
                listDetailVC.list = list
            }
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        listStore.moveListAtIndex((sourceIndexPath as NSIndexPath).row, toIndex: (destinationIndexPath as NSIndexPath).row)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let list = listStore.allLists[indexPath.row]
            let title = "Delete \(list.listName)?"
            let message = "Are you sure you want to delete this checklist?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                self.listStore.removeList(list)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            present(ac, animated: true, completion: nil)
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

