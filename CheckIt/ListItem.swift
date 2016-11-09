//
//  ListItem.swift
//  CheckIt
//
//  Created by Dan Esrey on 2016/09/11.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation

class ListItem: NSCoding {
    var itemID: Int
    var itemInfo: String
    
    init(itemID: Int, itemInfo: String) {
        self.itemID = itemID
        self.itemInfo = itemInfo
    }
    
    required init?(coder aDecoder: NSCoder) {
        <#code#>
    }
    
    func encode(with aCoder: NSCoder) {
        <#code#>
    }
    
}
