//
// Copyright (©) 2015 Mobile Academy. All rights reserved.
//

import Foundation

class SeparatorView: UICollectionReusableView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.barsBackgroundTintColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
