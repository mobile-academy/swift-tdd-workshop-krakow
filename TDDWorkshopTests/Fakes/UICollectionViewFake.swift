//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class UICollectionViewFake: UICollectionView {

    var reloadDataCalled = false

    override func reloadData() {
        reloadDataCalled = true
    }

}
