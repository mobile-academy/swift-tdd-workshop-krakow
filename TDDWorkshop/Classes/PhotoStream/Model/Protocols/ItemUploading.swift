//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

protocol ItemUploading {
    func uploadItem(streamItem: StreamItem, completion: (Bool, ErrorType?) -> ())
}