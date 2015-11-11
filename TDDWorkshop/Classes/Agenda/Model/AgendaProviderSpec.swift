import Foundation
import Quick
import Nimble

@testable
import TDDWorkshop

class AgendaProviderSpec: QuickSpec {
    override func spec() {
        var sut: AgendaProvider!
        
       	beforeEach {
            sut = AgendaProvider()
        }
        
        afterEach {
            sut = nil
        }
            
        describe("reloading agenda") {
            it("should load agenda items") {
                sut.reloadAgenda({})

                expect(sut.agendaItems).toEventually(haveCount(7))
            }

            it("should call completion when done") {
                waitUntil { done in
                    sut.reloadAgenda({
                        done()
                    })
                }
            }
        }
    }
}
