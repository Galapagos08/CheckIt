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
    
    convenience init?(dictionary: [String: Any]) {
        guard let itemInfo = dictionary[ListItem.itemInfoKey] as? String else
        {
            return nil
        }
        self.init(itemInfo: itemInfo, checked: false)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(itemInfo, forKey: "ItemInfo")
        aCoder.encode(checked, forKey: "Checked")
    }
    
    required init?(coder: NSCoder) {
        itemInfo = coder.decodeObject(forKey: "ItemInfo") as! String
        checked = coder.decodeBool(forKey: "Checked")
        super.init()
    }
    
//    func toggleChecked(){
//        checked = !checked
//    }
    
}

extension ListItem {
    @nonobjc static let itemInfoKey: String = "ItemInfo"
    @nonobjc static let checkedKey: String = "Checked"
}


