//
// Copyright (©) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

@objc class SpeakersCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    //MARK: Properties

    let speakers: Array<Speaker>

    //MARK: Initialisers

    init(speakers: Array<Speaker>) {
        self.speakers = speakers
    }

    //MARK: UICollection View Data Source

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.speakers.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(SpeakerCellIdentifier, forIndexPath: indexPath) as! SpeakerCollectionViewCell
        cell.titleLabel.text = self.speakers[indexPath.row].name
        cell.imageView.image = self.speakers[indexPath.row].photo
        return cell
    }
}
