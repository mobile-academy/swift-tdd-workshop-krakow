import Foundation
import Quick
import Nimble

@testable
import TDDWorkshop


class SpeakersCollectionViewDataSourceSpec: QuickSpec {
    override func spec() {
        describe("SpeakersCollectionViewDataSource") {

            var sut: SpeakersCollectionViewDataSource?
            var collectionView: UICollectionView?

            beforeEach {
                let speaker1 = Speaker(name:"Fixture Name 1", photo:nil)
                let speaker2 = Speaker(name:"Fixture Name 2", photo:nil)

                sut = SpeakersCollectionViewDataSource(speakers: [speaker1, speaker2])

                collectionView = UICollectionView(frame:CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
                collectionView?.registerClass(SpeakerCollectionViewCell.self, forCellWithReuseIdentifier: SpeakerCellIdentifier)
                collectionView?.frame = CGRectMake(0, 0, 320, 480)
                collectionView?.dataSource = sut
            }

            describe("number of items") {

                var numberOfItems: NSInteger?

                beforeEach {
                    numberOfItems = sut?.collectionView(collectionView!, numberOfItemsInSection:0)
                }

                it("should return number of items equal to number of speakers") {
                    expect(numberOfItems).to(equal(2))
                }
            }

            describe("cell for item at index path") {

                var cell: SpeakerCollectionViewCell?
                
                context("when it's the first row") {
                    
                    beforeEach {
                        cell = sut?.collectionView(collectionView!, cellForItemAtIndexPath:NSIndexPath(forItem:0, inSection:0)) as? SpeakerCollectionViewCell
                    }
                    
                    it("should return a cell with properly configured title") {
                        expect(cell?.titleLabel.text).to(equal("Fixture Name 1"))
                    }
                }
                
                context("when it's the second row") {

                    beforeEach {
                        cell = sut?.collectionView(collectionView!, cellForItemAtIndexPath:NSIndexPath(forItem:1, inSection:0)) as? SpeakerCollectionViewCell
                    }

                    it("should return a cell with properly configured title") {
                        expect(cell?.titleLabel.text).to(equal("Fixture Name 2"))
                    }
                }
            }
        }
    }
}
