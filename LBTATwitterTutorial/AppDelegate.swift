//
//  AppDelegate.swift
//  LBTATwitterTutorial
//
//  Created by Kevin Quisquater on 24/06/2017.
//  Copyright © 2017 Kevin Quisquater. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        window?.rootViewController = UINavigationController(rootViewController: HomeDatasourceController())
        
        return true
    }
}

