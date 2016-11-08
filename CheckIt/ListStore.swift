//
//  ListStore.swift
//  CheckIt
//
//  Created by Dan Esrey on 2016/08/11.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation

class ListStore {
    var allLists: [List] = []
    
    func moveListAtIndex(_ fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        let movedList = allLists[fromIndex]
        allLists.remove(at: fromIndex)
        allLists.insert(movedList, at: toIndex)
    }
    
    func createList(listName: String, listItem: String)-> List {
        let newList = List(listName: listName, listItem: listItem)
        return newList
    }
    
//    func removeList(_ list: List) {
//        if let index = allLists.index(of: list) {
//            allLists.remove(at: index)
//        }
//    }
    
}
