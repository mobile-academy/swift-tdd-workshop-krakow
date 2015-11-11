//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

@testable
import TDDWorkshop

class ImagePickerFactoryFake: ImagePickerCreating {

    var capturedSourceType: UIImagePickerControllerSourceType?
    var fakePicker: UIImagePickerController = UIImagePickerController()

    func createPickerWithSourceType(sourceType: UIImagePickerControllerSourceType) -> UIImagePickerController {
        capturedSourceType = sourceType
        return fakePicker
    }

}
