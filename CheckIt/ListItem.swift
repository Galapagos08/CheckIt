//
//  ListItem.swift
//  CheckIt
//
//  Created by Dan Esrey on 2016/09/11.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation

class ListItem: NSObject, NSCoding {
    var itemInfo: String
    var checked = false
    
    init(itemInfo: String, checked: Bool) {
        self.itemInfo = itemInfo
        self.checked = false
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(itemInfo, forKey: "ItemInfo")
        aCoder.encode(checked, forKey: "Checked")
    }
    
    required init?(coder: NSCoder) {
        itemInfo = coder.decodeObject(forKey: "iItemInfo") as! String
        checked = coder.decodeBool(forKey: "Checked")
        super.init()
    }
    
    func toggleChecked(){
        checked = !checked
    }
    
}
