//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

protocol SourceTypeAvailability {
    func availableSources() -> [UIImagePickerControllerSourceType]
}

class DefaultSourceTypeProvider: SourceTypeAvailability {

    //MARK: Public methods

    func availableSources() -> [UIImagePickerControllerSourceType] {
        var availableTypes = [UIImagePickerControllerSourceType]()
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            availableTypes.append(.PhotoLibrary)
        }
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            availableTypes.append(.Camera)
        }
        return availableTypes
    }
}
