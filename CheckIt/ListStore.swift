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
    let listArchiveURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory,
                                     in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("lists.archive")
    }()
    
    init() {
        if let archivedLists =
            NSKeyedUnarchiver.unarchiveObject(withFile: listArchiveURL.path) as? [List] {
            allLists += archivedLists
        }
    }
    
    func moveListAtIndex(_ fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        let movedList = allLists[fromIndex]
        allLists.remove(at: fromIndex)
        allLists.insert(movedList, at: toIndex)
    }
    
    func createList(listName: String)-> Void {
        let newList = List(listName: listName, listItems: [])
        allLists.append(newList)
        return
    }
    
    func createListItem(itemInfo: String)-> ListItem {
        let listItem = ListItem(itemInfo: itemInfo, checked: false)
        return listItem
    }
    
    func convertStringArray(someArray: [String])-> [ListItem] {
        var listItems = [ListItem]()
        if someArray.count != 0 {
            for item in someArray {
                let listItem = createListItem(itemInfo: item)
                listItems.append(listItem)
            }
            print(listItems[0].checked)
            return listItems
        }
        else {
            return listItems
        }
    }
    
    func saveChanges()-> Bool {
        return NSKeyedArchiver.archiveRootObject(allLists, toFile: listArchiveURL.path)
    }
}
