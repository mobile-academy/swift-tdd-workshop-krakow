//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

@testable
import TDDWorkshop

class SourceTypeAvailabilityFake: SourceTypeAvailability {

    var fakeSources = [UIImagePickerControllerSourceType]()

    func availableSources() -> [UIImagePickerControllerSourceType] {
        return fakeSources
    }


}
