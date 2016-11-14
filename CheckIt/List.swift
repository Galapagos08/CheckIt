//
//  List.swift
//  CheckIt
//
//  Created by Dan Esrey on 2016/07/11.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation

class List: NSObject, NSCoding {
    var listName: String
    var listItems = [ListItem]()
    
    init(listName: String) {
        self.listName = listName
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(listName, forKey: "listName")
        aCoder.encode(listItems, forKey: "listItems")
    }
    
    required init?(coder: NSCoder) {
        listName = coder.decodeObject(forKey: "listName") as! String
        listItems = coder.decodeObject(forKey: "listItems") as! [ListItem]
        super.init()
    }
}
