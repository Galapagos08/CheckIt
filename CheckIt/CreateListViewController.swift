//
//  CreateListViewController.swift
//  CheckIt
//
//  Created by Dan Esrey on 2016/14/11.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class CreateListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create List"
        self.navigationItem.rightBarButtonItem?.isEnabled = false
//        self.setEditing(true, animated: true)
    }

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
//        switch indexPath.section {
//        case 0:
//            cell.textField.text =
//        case 1:
//            cell.textField.text =
//        default:
//            break
//        }
//    }
//    
}
