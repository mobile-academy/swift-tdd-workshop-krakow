//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class PhotoStreamLayout: UICollectionViewFlowLayout {

    //MARK: Object Life Cycle

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sectionInset = UIEdgeInsets(top:10.0, left: 0.0, bottom:10.0, right:0.0)
        minimumInteritemSpacing = 5.0
        minimumLineSpacing = 5.0
        itemSize = CGSize(width: 90.0, height: 90.0)
    }
}
