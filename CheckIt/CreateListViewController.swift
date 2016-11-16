//
//  CreateListViewController.swift
//  CheckIt
//
//  Created by Dan Esrey on 2016/14/11.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class CreateListViewController: UITableViewController, UITextFieldDelegate {

    var listStore: ListStore = ListStore()
    var list: List!
    
    var listName: String = ""
    var listItems: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create List"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.register(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.setEditing(true, animated: true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("isEditing: \(isEditing)")
        switch section {
        case 0:
            return 1
        case 1 where isEditing:
            return listItems.count+1
        case 1:
            return listItems.count
        default:
            fatalError("Unexpected section")
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if indexPath.section == 1 {
            let rowCount = self.tableView(tableView, numberOfRowsInSection: indexPath.section)
            if rowCount-1 == indexPath.row {
                return .insert
            }
            return .delete
        }
        return .none
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        switch editingStyle {
        case .insert:
            listItems.append("item #\(listItems.count)")
            tableView.insertRows(at: [indexPath], with: .automatic)
        case .delete:
            listItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        default:
            break;
        }
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1 {
            return true
        }
        return false
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyCell
            cell.textField.placeholder = "List name"
            cell.textField.delegate = self
            return cell
        case 1 where isEditing && indexPath.row == listItems.count:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyCell
            cell.textField.placeholder = "List item"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyCell
            cell.textField.text = listItems[indexPath.row]
            return cell
        default:
            fatalError("Unexpected section")
        }
    }
    
    @IBAction func cancelButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var v: UIView = textField
        repeat {v = v.superview! } while !(v is UITableViewCell)
        let cell = v as! MyCell
        let indPth = self.tableView.indexPath(for: cell)!
        // app crashes if text field in section 1 is touched
       /* if indPth.section == 1 {
            if cell.textField.text != nil {
            self.listItems[indPth.row] = cell.textField.text!
            }
        } else */ if indPth.section == 0 {
            self.listName = cell.textField.text!
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    @IBAction func doneButton(_ sender: AnyObject) {
        let listName = self.listName
        listStore.createList(listName: listName)
        self.dismiss(animated: true, completion: nil)
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
    }
    
}
