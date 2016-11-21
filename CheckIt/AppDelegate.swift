//
//  AppDelegate.swift
//  CheckIt
//
//  Created by Dan Esrey on 2016/07/11.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let listStore = ListStore()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let listStore = ListStore()
        let rootViewController = window!.rootViewController as! UINavigationController
        let listsVC = rootViewController.topViewController as! ListsViewController
        listsVC.listStore = listStore
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        let success = listStore.saveChanges()
        if (success) {
             print("\(listStore.allLists.count)")           
        }
        
    }
    
}

