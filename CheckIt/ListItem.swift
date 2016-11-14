//
//  ListItem.swift
//  CheckIt
//
//  Created by Dan Esrey on 2016/09/11.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation

class ListItem: NSObject, NSCoding {
    var itemID: Int
    var itemInfo: String
    var checked = false
    
    init(itemID: Int, itemInfo: String, checked: Bool) {
        self.itemID = itemID
        self.itemInfo = itemInfo
        self.checked = false
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(itemID, forKey: "ItemID")
        aCoder.encode(itemInfo, forKey: "ItemInfo")
        aCoder.encode(checked, forKey: "Checked")
    }
    
    required init?(coder: NSCoder) {
        itemID = coder.decodeInteger(forKey: "ItemID")
        itemInfo = coder.decodeObject(forKey: "iItemInfo") as! String
        checked = coder.decodeBool(forKey: "Checked")
        super.init()
    }
    
    func toggleChecked(){
        checked = !checked
    }
    
}
