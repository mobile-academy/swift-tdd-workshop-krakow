//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit
import Parse

class StreamItemTransformer {

    //MARK: Constants

    let TitleKey = "title"
    let ImageDataKey = "imageData"

    //MARK: Public methods

    func streamItemFromParseObject(parseObject: PFObject) -> StreamItem? {
        guard let title = parseObject[TitleKey] as? String,
        let data = parseObject[ImageDataKey] as? NSData else {
            return nil
        }
        return StreamItem(title: title, imageData: data)
    }

    func parseObjectFromStreamItem(streamItem: StreamItem) -> PFObject {
        let object = PFObject(className: StreamItem.entityName)
        object[TitleKey] = streamItem.title
        object[ImageDataKey] = streamItem.imageData
        return object
    }
}
