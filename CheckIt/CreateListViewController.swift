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
        self.tableView.register(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.setEditing(true, animated: true)
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        switch indexPath.section {
        case 0:
            return .none
        case 1:
            return .insert
        default:
            break
        }
        return .none
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyCell
        _ = cell.textField
        switch indexPath.section {
        case 0:
            cell.textField.placeholder = "List name"
        case 1:
            cell.textField.placeholder = "List item"
        default:
            break
        }
        cell.textField.delegate = self
        return cell
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

}
