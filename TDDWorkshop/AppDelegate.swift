//
//  AppDelegate.swift
//  TDD Workshop
//
//  Created by Maciej Oczko on 03.07.2015.
//  Copyright © 2015 Mobile Academy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        modifyAppearance()
        return true
    }

    func modifyAppearance() {
        let workshopBackgroundColor = UIColor.barsBackgroundTintColor()
        let tintColor = UIColor.textColor()
        
        UINavigationBar.appearance().barTintColor = workshopBackgroundColor
        UINavigationBar.appearance().tintColor = tintColor
        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName : tintColor
        ]
        
        UITabBar.appearance().barTintColor = workshopBackgroundColor
        UITabBar.appearance().tintColor = tintColor
        
        UIRefreshControl.appearance().tintColor = tintColor
    }
}

