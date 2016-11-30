//
//  ChecklistItemCell.swift
//  CheckIt
//
//  Created by Dan Esrey on 2016/30/11.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class ChecklistItemCell: UITableViewCell {

    @IBOutlet weak var itemInfoTextField: UITextField!
    @IBOutlet weak var checkedLabel: UILabel!
    
    override func didTransition(to state: UITableViewCellStateMask) {
        self.itemInfoTextField.isEnabled = state.contains(.showingEditControlMask)
        super.didTransition(to: state)
    }
}
