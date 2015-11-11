//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class StreamItem {
    var title: String
    var imageData: NSData

    static let entityName = "StreamItem"

    init(title: String, imageData: NSData) {
        self.title = title
        self.imageData = imageData
    }
}

extension StreamItem {
    func image() -> UIImage? {
        return UIImage(data: imageData)
    }
}