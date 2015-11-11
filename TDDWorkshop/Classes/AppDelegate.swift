//
//  Copyright © 2015 Mobile Academy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //MARK: UIApplicationDelegate

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        configureApplication(launchOptions)
        modifyAppearance()
        return true
    }

    //MARK: Helpers

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

    func configureApplication(launchOptions: [NSObject: AnyObject]?) {
        let configurator = Configurator()
        let appConfiguration = ConfigurationFactory().applicationConfiguration()
        configurator.configureApplication(appConfiguration, launchOptions: launchOptions)
    }
}

