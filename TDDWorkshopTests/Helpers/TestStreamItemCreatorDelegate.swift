//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

@testable
import TDDWorkshop

class TestStreamItemCreatorDelegate: ItemCreatingDelegate {

    var capturedStreamItem: StreamItem?
    var capturedError: ErrorType?

    //MARK: ItemCreatingDelegate

    func creator(creator: ItemCreating, didCreateItem item: StreamItem) {
        capturedStreamItem = item
    }

    func creator(creator: ItemCreating, failedWithError error: ErrorType) {
        capturedError = error
    }

}
