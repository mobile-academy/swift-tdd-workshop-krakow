import Quick
import Nimble

@testable
import TDDWorkshop

class StreamItemViewControllerSpec: QuickSpec {
    override func spec() {
        describe("StreamItemViewController") {
            var sut: StreamItemViewController!

            beforeEach {
                let storyboard = UIStoryboard(name: "PhotoStream", bundle: nil)
                sut = storyboard.instantiateViewControllerWithIdentifier("StreamItemPreview") as! StreamItemViewController
            }
            it("should work") {
                expect(sut).notTo(beNil())
            }
        }
    }
}