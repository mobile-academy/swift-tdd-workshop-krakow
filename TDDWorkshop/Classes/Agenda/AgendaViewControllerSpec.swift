import Foundation
import Quick
import Nimble

@testable
import TDDWorkshop

class AgendaViewControllerSpec: QuickSpec {
    override func spec() {
        var sut: AgendaViewController!

        beforeEach {
            let storyboard = UIStoryboard(name: "Agenda", bundle: nil)
            let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
            sut = navigationController.viewControllers.first as! AgendaViewController
        }

        afterEach {
            sut = nil
        }

        describe("setup") {
            it("should have an instance of an AgendaProvider") {
                expect(sut.agendaProvider).notTo(beNil())
            }
        }

        describe("navigation title") {
            it("should be set") {
                expect(sut.navigationItem.title).to(equal("Agenda"))
            }
        }

        describe("tab bar item") {
            var tabBarItem: UITabBarItem!
            beforeEach {
                tabBarItem = sut.navigationController!.tabBarItem
            }

            it("should have image setup") {
                expect(tabBarItem.selectedImage).to(equal(UIImage(named: "Agenda")))
            }

            it("should have title setup") {
                expect(tabBarItem.title).to(equal("Agenda"))
            }
        }

        describe("view loading") {
            var agendaProviderFake: AgendaProviderFake!

            beforeEach {
                // Arrange

            }

            // Un-exlude
            xit("should reload agenda") {
                // Act

                // Assert

            }
        }
    }
}
