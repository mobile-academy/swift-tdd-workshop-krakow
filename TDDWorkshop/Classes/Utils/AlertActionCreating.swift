//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

protocol AlertActionCreating {
    func createActionWithTitle(title: String, style: UIAlertActionStyle, handler: (UIAlertAction) -> ()) -> UIAlertAction
}

class DefaultAlertActionFactory: AlertActionCreating {
    func createActionWithTitle(title: String, style: UIAlertActionStyle, handler: (UIAlertAction) -> ()) -> UIAlertAction {
        return UIAlertAction(title: title, style: style, handler: handler)
    }
}
