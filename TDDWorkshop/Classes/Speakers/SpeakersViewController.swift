//
//  Copyright © 2015 Mobile Academy. All rights reserved.
//

import UIKit

class SpeakersViewController: UICollectionViewController {

    //MARK: Properties

    var dataSource: SpeakersCollectionViewDataSource? {
        didSet {
            self.collectionView?.dataSource = self.dataSource
        }
    }

    //MARK: Initialisers

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.title = "Speakers"
        self.dataSource = SpeakersCollectionViewDataSource(speakers: self.defaultSpeakers())
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    //MARK: Init Helpers

    func defaultSpeakers() -> Array<Speaker> {
        let resourcePath = NSBundle.mainBundle().pathForResource("speakers", ofType: "JSON")!
        let data = NSData(contentsOfFile: resourcePath)!

        var speakersArray: Array<Speaker> = Array()

        do {
            let unparsedSpeakers = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? Array<Dictionary<String, String>>
            for speakerDictionary in unparsedSpeakers! {

                let speakerImageName = speakerDictionary["image"]
                var image: UIImage?

                if speakerImageName != nil {
                    image = UIImage(named: speakerImageName!)
                }

                let speaker = Speaker(name: speakerDictionary["name"]!, photo: image)
                speakersArray.append(speaker)
            }

        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        } 

        return speakersArray
    }

    //MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.alwaysBounceVertical = true
        self.collectionView?.dataSource = self.dataSource
        self.collectionView?.registerClass(SpeakerCollectionViewCell.self, forCellWithReuseIdentifier:SpeakerCellIdentifier)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let layout: UICollectionViewFlowLayout = self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 80)
    }
}

