//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
@testable
import TDDWorkshop

class StreamItemUploaderFake: ItemUploading {

    var uploadItemCalled = false
    var capturedCompletion: ((Bool, ErrorType?) -> ())?

    func uploadItem(streamItem: StreamItem, completion: (Bool, ErrorType?) -> ()) {
        uploadItemCalled = true
        capturedCompletion = completion
    }

}
