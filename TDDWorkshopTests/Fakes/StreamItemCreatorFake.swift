//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

@testable
import TDDWorkshop

class StreamItemCreatorFake: ItemCreating {

    weak var delegate: ItemCreatingDelegate?

    var createItemCalled = false

    func createStreamItem() {
        createItemCalled = true
    }

}
