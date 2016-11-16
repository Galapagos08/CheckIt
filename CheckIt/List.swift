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
    var listItems: [ListItem]
    
    init(listName: String, listItems: [ListItem]) {
        self.listName = listName
        self.listItems = listItems
        super.init()
    }
    
    convenience init?(dictionary: [String: Any]) {
        guard let listName = dictionary[List.listNameKey] as? String,
            let listItems = dictionary[List.listItemsKey] as? [ListItem] else {
                return nil
        }
        self.init(listName: listName, listItems: listItems)
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

extension List {
    @nonobjc static let listNameKey: String = "listName"
    @nonobjc static let listItemsKey: String = "listItems"
}
