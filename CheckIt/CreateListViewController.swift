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
    var newListName: String = ""
    var newListItems: [String] = []
    
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
        switch section {
        case 0:
            return 1
        case 1 where isEditing:
            return newListItems.count+1
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
            newListItems.append("\(newListItems.count+1)")
            tableView.insertRows(at: [indexPath], with: .automatic)
        case .delete:
            newListItems.remove(at: indexPath.row)
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
        case 1 where isEditing && indexPath.row == newListItems.count:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyCell
            cell.textField.text = "add list item"
            cell.textField.isEnabled = false
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyCell
            cell.textField.placeholder = newListItems[indexPath.row]
            cell.textField.delegate = self
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
        if indPth.section == 1 {
// this causes crash if editing is a deletion and textfield is empty
            self.newListItems[indPth.row] = ("\(cell.textField.text!)")
        } else if indPth.section == 0 {
            self.newListName = cell.textField.text!
        }
    }
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        let listName = self.newListName
        listStore.createList(listName: listName)
        let list = listStore.allLists.last!
        let listItems = listStore.convertStringArray(someArray: newListItems)
        list.listItems = listItems
        print("\nadded \(listStore.allLists.count) to allLists\n")
        self.dismiss(animated: true, completion: nil)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
// if text is added to a field and button becomes enabled, entering and then deleting text in a separte field can cause button to become disabled
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if !text.isEmpty {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } 
        return true
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
    }
    
}
