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
        let rootViewController = window!.rootViewController as! UINavigationController
        let listsVC = rootViewController.topViewController as! ListsViewController
        listsVC.listStore = listStore
        UINavigationBar.appearance().barTintColor = UIColor.init(red: 0, green: 121/255, blue: 1, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)]
        UINavigationBar.appearance().tintColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        return true
    }

}

