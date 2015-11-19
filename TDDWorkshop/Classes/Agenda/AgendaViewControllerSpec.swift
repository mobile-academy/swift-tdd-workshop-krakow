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
                agendaProviderFake = AgendaProviderFake()
                sut.agendaProvider = agendaProviderFake
            }

            it("should reload agenda") {
                // Act
                sut.viewDidLoad()

                // Assert
                expect(agendaProviderFake.reloadAgendaCalled) == true
            }

            describe("agenda reloading completes") {
                var tableViewFake: UITableViewFake!
                beforeEach {
                    // Arrange
                    tableViewFake = UITableViewFake()
                    sut.tableView = tableViewFake
                }

                it("should reload table view") {
                    // Act
                    sut.viewDidLoad()

                    // Simulate
                    agendaProviderFake.simulateSuccessfulReload([])

                    // Assert
                    expect(tableViewFake.reloadDataCalled) == true
                }
            }
        }

        describe("table view") {
            var tableView: UITableView!
            var agendaProviderFake: AgendaProviderFake!

            beforeEach {
                tableView = sut.tableView

                agendaProviderFake = AgendaProviderFake()
                sut.agendaProvider = agendaProviderFake
            }

            it("should have 1 section") {
                expect(tableView.numberOfSections) == 1
            }

            describe("number of rows") {
                context("when agenda is empty") {
                    beforeEach {
                        agendaProviderFake.agendaItems = []
                    }

                    it("should have 0 rows") {
                        expect(tableView.dataSource!.tableView(tableView, numberOfRowsInSection: 0)) == 0
                    }
                }

                context("when agenda has 2 items") {
                    beforeEach {
                        agendaProviderFake.agendaItems = [
                                AgendaItem(time: "111", name: "111"),
                                AgendaItem(time: "222", name: "222")
                        ]
                    }

                    it("should have 2 rows") {
                        expect(tableView.dataSource!.tableView(tableView, numberOfRowsInSection: 0)) == 2
                    }

                    it("should return cell for each item") {
                        for i in 0 ..< agendaProviderFake.agendaItems.count {
                            let agendaItem = agendaProviderFake.agendaItems[i]
                            let indexPath = NSIndexPath(forRow: i, inSection: 0)

                            let agendaItemCell = tableView.dataSource?.tableView(tableView, cellForRowAtIndexPath: indexPath) as! AgendaItemCell

                            expect(agendaItemCell).notTo(beNil())
                            expect(agendaItemCell.timeLabel.text) == agendaItem.time
                            expect(agendaItemCell.nameLabel.text) == agendaItem.name
                        }
                    }
                }
            }
        }
    }
}
