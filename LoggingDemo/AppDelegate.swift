//
//  AppDelegate.swift
//  LoggingDemo
//
//  Created by Al Wold on 8/28/17.
//  Copyright © 2017 Al Wold. All rights reserved.
//

import UIKit
import os.log

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        os_log("App starting", log: Logs.shared.defaultLog, type: .info)
        return true
    }
}

