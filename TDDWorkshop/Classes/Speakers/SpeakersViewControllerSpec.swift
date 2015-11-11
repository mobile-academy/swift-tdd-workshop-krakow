import Foundation
import Quick
import Nimble

@testable
import TDDWorkshop

class SpeakersViewControllerSpec: QuickSpec {
    override func spec() {
        describe("SpeakersViewController") {

            var sut: SpeakersViewController!

            beforeEach {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)

                sut = storyboard.instantiateViewControllerWithIdentifier("Speakers") as! SpeakersViewController
            }

            afterEach {
                sut = nil
            }

            it("should have a title") {
                expect(sut.title).to(equal("Speakers"))
            }

            describe("collection view") {

                var view: UICollectionView?

                beforeEach {
                    view = sut.collectionView
                }

                it("should always bounce vertically") {
                    expect(view?.alwaysBounceVertical).to(beTruthy())
                }

                describe("layout") {

                    var layout: UICollectionViewFlowLayout?

                    beforeEach {
                        layout = view?.collectionViewLayout as? UICollectionViewFlowLayout
                    }

                    //TODO: Just don't forget to implement test for layout before doing the workshop

                    describe("when the view lays itself out") {

                        beforeEach {
                            sut.view.bounds = CGRectMake(0, 0, 42, 120)
                            sut.view.layoutIfNeeded()
                        }

                        it("should set the item size on collection view layout") {
                            expect(layout?.itemSize).to(equal(CGSizeMake(42, 80)))
                        }
                    }
                }
            }

            describe("speakers data source") {

                var dataSource: SpeakersCollectionViewDataSource?

                beforeEach {
                    dataSource = sut.dataSource
                }

                it("should be a speakers data source") {
                    expect(dataSource).notTo(beNil())
                }

                it("should be view controllers collection view data source") {
                    let dataSourceSet = sut.collectionView?.dataSource === dataSource
                    expect(dataSourceSet).to(beTruthy())
                }

                describe("speakers") {

                    var speakers: Array<Speaker>?

                    beforeEach {
                        speakers = dataSource?.speakers
                    }

                    it("should have four speakers") {
                        expect(speakers).to(haveCount(4))
                    }

                    describe("first speaker") {

                        var speaker: Speaker?

                        beforeEach {
                            speaker = speakers?[0]
                        }

                        it("should have a name") {
                            expect(speaker?.name).to(equal("Paweł Dudek"))
                        }
                    }
                }
            }
        }
    }
}
