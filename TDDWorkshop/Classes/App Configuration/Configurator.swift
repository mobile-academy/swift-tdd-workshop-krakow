//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import Parse

class Configurator {

    func configureApplication(configuration: Configuration, launchOptions: [NSObject: AnyObject]?) {
        Parse.setApplicationId(configuration.parseApplicationID, clientKey: configuration.parseClientID)
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
    }
}
