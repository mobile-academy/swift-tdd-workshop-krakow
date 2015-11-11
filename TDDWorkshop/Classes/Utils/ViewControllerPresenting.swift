//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

protocol ViewControllerPresenting {

    weak var viewController: UIViewController? {get set}

    func presentViewController(viewController: UIViewController)
    func dismissViewController(viewController: UIViewController)
}

class DefaultViewControllerPresenter: ViewControllerPresenting {

    weak var viewController: UIViewController?

    func presentViewController(viewController: UIViewController) {
        self.viewController?.presentViewController(viewController, animated: true, completion: nil)
    }

    func dismissViewController(viewController: UIViewController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }

}
