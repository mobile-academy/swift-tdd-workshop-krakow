import Quick
import Nimble

@testable
import TDDWorkshop

class StreamItemUploaderSpec: QuickSpec {
    override func spec() {
        describe("StreamItemUploader") {

            var sut: StreamItemUploader!
            var parseAdapter: ParseAdapterFake!

            beforeEach {
                parseAdapter = ParseAdapterFake()
                sut = StreamItemUploader(parseAdapter: parseAdapter)
            }

            describe("upload item") {

                var fixtureItem: StreamItem!
                var capturedSuccess: Bool?
                var capturedError: ErrorType?

                beforeEach {
                    fixtureItem = StreamItem(title: "Foo Bar", imageData: NSData())
                    capturedSuccess = nil
                    sut.uploadItem(fixtureItem) {
                        success, error in
                        capturedSuccess = success
                        capturedError = error
                    }
                }
                it("should upload parse object") {
                    expect(parseAdapter.capturedUploadedObject).notTo(beNil())
                }
                it("should upload object with proper title") {
                    let object = parseAdapter.capturedUploadedObject!
                    let title = object["title"] as? String
                    expect(title).notTo(beNil())
                    expect(title) == "Foo Bar"
                }
                it("should upload object with image data") {
                    let object = parseAdapter.capturedUploadedObject!
                    expect(object["imageData"] as? NSData).notTo(beNil())
                }

                context("when it succeeds") {
                    beforeEach {
                        parseAdapter.capturedUploadCompletion?(true, nil)
                    }
                    it("should call completion") {
                        expect(capturedSuccess).notTo(beNil())
                    }
                    it("should call completion with true flag") {
                        expect(capturedSuccess!) == true
                    }
                    it("should call completion without error") {
                        expect(capturedError).to(beNil())
                    }
                }
                context("when it fails") {
                    beforeEach {
                        let error = NSError(domain: "Foo", code: 123, userInfo: nil)
                        parseAdapter.capturedUploadCompletion?(false, error)
                    }
                    it("should call completion") {
                        expect(capturedSuccess).notTo(beNil())
                    }
                    it("should call completion with false flag") {
                        expect(capturedSuccess!) == false
                    }
                    it("should call completion with error") {
                        expect(capturedError).notTo(beNil())
                    }
                }
            }
        }
    }
}