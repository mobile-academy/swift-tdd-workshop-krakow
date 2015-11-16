//
// Created by Maciej Oczko on 16.11.2015.
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable
import TDDWorkshop

class PollViewControllerSpec: QuickSpec {
    override func spec() {
        var sut: PollViewController!
        var pollSender: FakePollManager!
        var pollBuilder: PollBuilder!

        beforeEach() {
            pollSender = FakePollManager()
            pollBuilder = PollBuilder()
            let storyboard = UIStoryboard(name: "Poll", bundle: nil)
            sut = storyboard.instantiateViewControllerWithIdentifier("Poll") as! PollViewController
            sut.pollManager = pollSender
            sut.pollBuilder = pollBuilder
        }

        afterEach {
            sut = nil
        }

        describe("initialization") {

            it("should hava a title") {
                expect(sut.title).to(equal("Feedback"))
            }

        }

        describe("navigation item configuration") {

            var navigationController: UINavigationController!

            beforeEach {
                navigationController = UINavigationController(rootViewController: sut)
            }

            afterEach {
                navigationController = nil
            }

            // About `sut.view`:
            // To simulate normal view controller life cycle you can call the `view` property on it.
            // It's equal to call `loadView()` and `viewDidLoad()` method.

            it("should set navigation item") {
                pollSender.pollAlreadySent = false
                let _ = sut.view
                sut.viewWillAppear(false)
                expect(sut.navigationItem.rightBarButtonItem).toNot(beNil())
            }

            it("should nil out navigation item") {
                pollSender.pollAlreadySent = true
                let _ = sut.view
                sut.viewWillAppear(false)
                expect(sut.navigationItem.rightBarButtonItem).to(beNil())
            }

        }

        describe("sending poll") {

            var navigationController: UINavigationController!

            beforeEach {
                navigationController = UINavigationController(rootViewController: sut)
                pollSender.pollAlreadySent = false
                sut.sendPoll()
            }

            afterEach {
                navigationController = nil
            }

            it("should send poll with sender") {
                expect(pollSender.didCallSendPoll).to(beTrue())
            }

            it("should nil out button item") {
                expect(sut.navigationItem.rightBarButtonItem).to(beNil())
            }

        }
    }

    class FakePollManager: PollSender {

        var pollAlreadySent: Bool = false
        var completionFlag: Bool = true
        private(set) var didCallSendPoll: Bool = false

        func isPollAlreadySent() -> Bool {
            return pollAlreadySent
        }

        func sendPoll(poll: Poll, completion: ((Bool, NSError?) -> ())?) {
            self.didCallSendPoll = true
            if let completion = completion {
                completion(self.completionFlag, nil)
            }
        }
    }

}

