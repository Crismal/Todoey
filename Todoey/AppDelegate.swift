//
//  AppDelegate.swift
//  Todoey
//
//  Created by Cristian Misael Almendro Lazarte on 6/22/19.
//  Copyright © 2019 Cristian Misael Almendro Lazarte. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print(Realm.Configuration.defaultConfiguration.fileURL as Any)
 
        return true
        
    }
}

