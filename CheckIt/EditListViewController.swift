//
//  EditListViewController.swift
//  CheckIt
//
//  Created by Dan Esrey on 2016/01/12.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class EditListViewController: UITableViewController, UITextFieldDelegate {

    var list: List!
    var listStore: ListStore!
    var listNameTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        switch section {
        case 0:
            return 1
        case 1 where isEditing:
            return list.listItems.count+1
        default:
            fatalError("Unexpected section in editListVC")
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
            let newListItem = listStore.createListItem(itemInfo: "")
            list.listItems.append(newListItem)
            tableView.insertRows(at: [indexPath], with: .automatic)
        case .delete:
            list.listItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyCell
        switch indexPath.section {
        case 0:
            listNameTextField = cell.textField
            cell.textField.text = list.listName
            cell.textField.delegate = self
        case 1 where isEditing && indexPath.row == list.listItems.count:
            cell.textField.text = "add list item"
            cell.textField.isEnabled = false
        case 1:
            let listItem = list.listItems[indexPath.row]
            cell.textField.text = listItem.itemInfo
            cell.textField.placeholder = "new list item"
            cell.textField.delegate  = self
            cell.textField.tag = indexPath.row
        default:
            fatalError("You have an unexpected section")
        }
        return cell
    }
 
    @IBAction func cancelButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func doneButton(_ sender: AnyObject) {
        listStore.saveChanges()
        self.dismiss(animated: false, completion: nil)
    }
    
 
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == listNameTextField {
            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            self.list.listName = text
            if text.isEmpty {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            } else {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
        } else {
            let row = textField.tag
            list.listItems[row].itemInfo = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        return true
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
    }

}
