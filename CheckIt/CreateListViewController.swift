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
    var listName: String = ""
    var listItems: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create List"
        self.tableView.register(MyCell.self, forCellReuseIdentifier: "Cell")
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
//        switch indexPath.section {
//        case 0:
//            cell.textField.text = self.listName
//        case 1:
//            cell.textField.text = self.listItems[indexPath.row]
//        default:
//            break
//        }
//        cell.textField.delegate = self
        return cell
    }
    
    @IBAction func cancelButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.endEditing(true)
//        return false
//    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        var v: UIView = textField
//        repeat {v = v.superview! } while !(v is UITableViewCell)
//        let cell = v as! MyCell
//        let ip = self.tableView.indexPath(for: cell)!
//        if ip.section == 1 {
//            self.listItems[ip.row] = cell.textField.text!
//        } else if ip.section == 0 {
//            self.listName = cell.textField.text!
//        }
//    }
    
}
