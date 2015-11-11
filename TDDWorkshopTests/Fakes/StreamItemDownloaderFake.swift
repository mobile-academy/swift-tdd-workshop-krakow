//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
@testable
import TDDWorkshop

class StreamItemDownloaderFake: ItemDownloading {
    var capturedCompletion: (([StreamItem]?, ErrorType?) -> ())?
    var downloadItemsCalled : Bool = false

    func downloadItems(completion: ([StreamItem]?, ErrorType?) -> ()) {
        capturedCompletion = completion
        downloadItemsCalled = true
    }
}
