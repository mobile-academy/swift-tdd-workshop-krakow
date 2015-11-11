//
// Copyright (©) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class SpeakersCollectionViewLayout: UICollectionViewFlowLayout {

    override func prepareLayout() {
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = 0

        super.prepareLayout()

        self.registerClass(SeparatorView.self, forDecorationViewOfKind: "Separator")
    }

    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = super.layoutAttributesForElementsInRect(rect)
        if let actualAttributes = attributes {
            let separatorsAttributes = self.separatorAttributesForBaseAttributes(actualAttributes)
            attributes?.appendContentsOf(separatorsAttributes)
        }

        return attributes
    }

    override func layoutAttributesForDecorationViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let cellAttributes = self.layoutAttributesForItemAtIndexPath(indexPath)
        return self.layoutAttributesForDecorationViewOfKind(kind: elementKind, forCellAttributes: cellAttributes)
    }

    private func separatorAttributesForBaseAttributes(attributes: Array<UICollectionViewLayoutAttributes>) -> Array<UICollectionViewLayoutAttributes> {
        var separatorsAttributes: Array<UICollectionViewLayoutAttributes> = Array()

        for layoutAttributes in attributes {
            let isCellAttribute = layoutAttributes.representedElementCategory == .Cell
            let isNotLastCellInSection = !self.isIndexPathLastInSection(indexPath: layoutAttributes.indexPath)
            if (isCellAttribute && isNotLastCellInSection) {
                let separatorAttributes = self.layoutAttributesForDecorationViewOfKind(kind: "Separator", forCellAttributes:layoutAttributes)
                separatorsAttributes.append(separatorAttributes)
            }
        }
        return separatorsAttributes
    }

    private func layoutAttributesForDecorationViewOfKind(kind kind: String, forCellAttributes cellAttributes: UICollectionViewLayoutAttributes?) -> UICollectionViewLayoutAttributes {
        let indexPath = cellAttributes?.indexPath

        let decorationAttributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: "Separator", withIndexPath: indexPath!)
        decorationAttributes.bounds = CGRectMake(0, 0, CGRectGetWidth(self.collectionView!.bounds), 1 / UIScreen.mainScreen().scale)
        decorationAttributes.center = CGPointMake(CGRectGetMidX(self.collectionView!.bounds), CGRectGetMaxY(cellAttributes!.frame))
        return decorationAttributes
    }

    private func isIndexPathLastInSection(indexPath indexPath: NSIndexPath) -> Bool {
        let index = self.collectionView!.numberOfItemsInSection(indexPath.section)
        return indexPath.row == index
    }
}
