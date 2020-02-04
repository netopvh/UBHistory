//
//  AppDelegate.swift
//  UBHistory
//
//  Created by Tulio Parreiras on 03/08/2019.
//  Copyright (c) 2019 Tulio Parreiras. All rights reserved.
//

import UIKit
import UBHistory

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var historyCoordinator: HistoryCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let view = ViewController()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = view
        self.window?.makeKeyAndVisible()
        return true
    }

}
