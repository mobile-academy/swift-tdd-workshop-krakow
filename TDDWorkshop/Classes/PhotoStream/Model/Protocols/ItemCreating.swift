//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

protocol ItemCreatingDelegate: class {
    func creator(creator: ItemCreating, didCreateItem item: StreamItem)
    func creator(creator: ItemCreating, failedWithError: ErrorType)
}

protocol ItemCreating {

    weak var delegate: ItemCreatingDelegate? {get set}
    func createStreamItem()
}