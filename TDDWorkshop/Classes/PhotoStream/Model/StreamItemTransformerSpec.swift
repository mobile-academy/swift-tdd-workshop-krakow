import Quick
import Nimble
import Parse

@testable
import TDDWorkshop

class StreamItemTransformerSpec: QuickSpec {
    override func spec() {

        describe("StreamItemTransformer") {
            var sut: StreamItemTransformer!

            beforeEach {
                sut = StreamItemTransformer()
            }

            describe("transform stream item into Parse object") {
                var parseObject: PFObject!
                var streamItem: StreamItem!
                let fakeImageData = NSData()

                beforeEach {
                    streamItem = StreamItem(title: "Foo 123", imageData: fakeImageData)
                    parseObject = sut.parseObjectFromStreamItem(streamItem)
                }
                it("should set title under 'title' key") {
                    let title = parseObject["title"] as? String
                    expect(title).notTo(beNil())
                    expect(title!) == "Foo 123"
                }
                it("should set image data under 'imageData' key") {
                    let data = parseObject["imageData"] as? NSData
                    expect(data).notTo(beNil())
                    expect(data!) == fakeImageData
                }
            }

            describe("transform parse object into Stream Item") {
                var streamItem : StreamItem?
                var parseObject : PFObject!
                let fakeImageData = NSData()

                beforeEach {
                    streamItem = nil
                    parseObject = PFObject(className: StreamItem.entityName)
                }
                context("when it has title and image data") {
                    beforeEach {
                        parseObject["title"] = "Foo Bar"
                        parseObject["imageData"] = fakeImageData
                        streamItem = sut.streamItemFromParseObject(parseObject)
                    }
                    it("should create Stream Item") {
                        expect(streamItem).notTo(beNil())
                    }
                    it("should set proper title on Stream Item") {
                        expect(streamItem!.title) == "Foo Bar"
                    }
                    it("should set image data on Stream Item") {
                        expect(streamItem!.imageData) == fakeImageData
                    }
                }
                context("when it does NOT have title") {
                    beforeEach {
                        parseObject["imageData"] = NSData()
                        streamItem = sut.streamItemFromParseObject(parseObject)
                    }
                    it("should NOT create Stream Item") {
                        expect(streamItem).to(beNil())
                    }
                }
                context("when it does NOT have image data") {
                    beforeEach {
                        parseObject["title"] = "Foo Bar"
                        streamItem = sut.streamItemFromParseObject(parseObject)
                    }
                    it("should NOT create Stream Item") {
                        expect(streamItem).to(beNil())
                    }
                }
                context("when it does NOT have title, NOR image data") {
                    beforeEach {
                        streamItem = sut.streamItemFromParseObject(parseObject)
                    }
                    it("should NOT create Stream Item") {
                        expect(streamItem).to(beNil())
                    }
                }
            }
        }
    }
}