//
//  PollViewController.swift
//  TDD Workshop
//
//  Created by Maciej Oczko on 03.07.2015.
//  Copyright © 2015 Mobile Academy. All rights reserved.
//

// TODO 1: Add spec file for PollViewController

import UIKit
import Eureka

typealias Emoji = String
let 🎉 = "🎉", 👍🏻 = "👍🏻", 😎 = "😎", 👎🏻 = "👎🏻", 😡 = "😡"
let symbols = [
        "🎉": 5,
        "👍🏻": 4,
        "😎": 3,
        "👎🏻": 2,
        "😡": 1
]

class PollViewController: FormViewController {
    let sections = ["Intro", "Testing techniques", "Red Green Refactor", "Working with Legacy Code"]
    var pollBuilder: PollBuilder = PollBuilder()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        title = "Feedback"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureForm()
    }

    override func viewWillAppear(animated: Bool) {
        // TODO 2: Write test that checks whether `rightBarButtonItem` is being set correctly depending on `pollAlreadySent` flag.
        // Then, think what else could be tested for this class.
        self.navigationItem.rightBarButtonItem =
                PollManager.sharedInstance.pollAlreadySent
                ? nil
                : UIBarButtonItem(title: "Send", style: .Plain, target: self, action: "didTapSend")

    }

    func didTapSend() {
        guard self.pollBuilder.isValid() else {
            self.showInvalidPollAlert()
            return
        }

        let sendAction = UIAlertAction(title: "Yes", style: .Default) {
            [weak self] _ in
            self?.sendPoll()
        }

        let alert = UIAlertController(title: "Confirmation", message: "You can send it only once.\nDo you want to continue?", preferredStyle: .Alert)

        alert.addAction(sendAction)
        alert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: nil))
        alert.preferredAction = sendAction

        self.presentViewController(alert, animated: true, completion: nil)
    }

    func sendPoll() {
        let poll = self.pollBuilder.poll()
        PollManager.sharedInstance.sendPoll(poll) {
            [weak self] success in
            if success {
                self?.navigationItem.setRightBarButtonItem(nil, animated: true)
            }
        }
    }

    func showInvalidPollAlert() {
        let alert = UIAlertController(title: "Error", message: "Can't send poll.\nFields with * are required.", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    // MARK: Form configuration

    func configureForm() {
        configureGeneralSection()
        configureAgendaSections()
    }

    func configureGeneralSection() {
        form +++ Section("General")
                <<<
                NameRow("name") {
                    $0.title = "Name*"
                    $0.placeholder = "John Smith?"
                }
                .onCellHighlight {
                    [weak self] (_, row) in
                    row.onCellUnHighlight {
                        (_, row) in
                        guard let _self = self else {
                            return
                        }
                        if _self.validateText(row.value) {
                            _self.pollBuilder.setName(row.value)
                        } else {
                            _self.showInvalidValueAlert(row.value)
                        }
                    }
                }
                <<<
                EmailRow("username") {
                    $0.title = "E-mail*"
                    $0.placeholder = "you@example.com"
                }
                .onCellHighlight {
                    [weak self] (_, row) in
                    row.onCellUnHighlight {
                        (_, row) in
                        guard let _self = self else {
                            return
                        }
                        if _self.validateEmail(row.value) {
                            _self.pollBuilder.setEmail(row.value)
                        } else {
                            _self.showInvalidValueAlert(row.value)
                        }
                    }
                }
                <<<
                TextAreaRow("feedback") {
                    $0.title = "General feedback"
                    $0.placeholder = "Write general feedback..."
                }
                .onCellUnHighlight {
                    [weak self] (cell, row) in
                    guard let _self = self else {
                        return
                    }
                    if _self.validateComment(row.value) {
                        _self.pollBuilder.setComments(row.value)
                    } else {
                        _self.showInvalidValueAlert(row.value)
                    }
                }
    }

    func configureAgendaSections() {
        for (i, section) in sections.enumerate() {
            form +++ Section(section)
                    <<<
                    SegmentedRow<Emoji>("rate\(i)") {
                        [weak self] in
                        $0.title = "What's your rate?"
                        $0.options = [🎉, 👍🏻, 😎, 👎🏻, 😡]
                        $0.value = 🎉
                        guard let _self = self else {
                            return
                        }
                        _self.pollBuilder.setRate(symbols[🎉], forTitle: section)
                    }
                    .onChange {
                        [weak self] row in
                        guard let value = row.value else {
                            return
                        }
                        guard let _self = self else {
                            return
                        }
                        _self.pollBuilder.setRate(symbols[value], forTitle: section)
                    }
                    <<<
                    TextAreaRow("comment\(i)") {
                        $0.title = "Comments"
                        $0.placeholder = "Write your comments here..."
                    }
                    .onCellUnHighlight {
                        [weak self] (cell, row) in
                        guard let _self = self else {
                            return
                        }
                        if _self.validateComment(row.value) {
                            _self.pollBuilder.setComment(row.value, forTitle: section)
                        } else {
                            _self.showInvalidValueAlert(row.value)
                        }
                    }
        }
    }

    func showInvalidValueAlert(value: String?) {
        if let printableValue = value {
            let message = "Value you entered is invalid: \"\(printableValue)\""
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    // MARK: Validation

    func validateComment(comment: String?) -> Bool {
        guard let comment = comment where !comment.isEmpty else {
            return false
        }
        return comment.characters.count > 10
    }

    func validateEmail(email: String?) -> Bool {
        guard let email = email where !email.isEmpty else {
            return false
        }
        let pattern = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let regex = NSPredicate(format: "SELF MATCHES %@", pattern)
        return regex.evaluateWithObject(email)
    }

    func validateText(text: String?) -> Bool {
        guard let text = text where !text.isEmpty else {
            return false
        }
        return [
                NSCharacterSet.illegalCharacterSet(),
                NSCharacterSet.symbolCharacterSet(),
                NSCharacterSet.punctuationCharacterSet(),
                NSCharacterSet.nonBaseCharacterSet(),
                NSCharacterSet.controlCharacterSet(),
        ].reduce(true) {
            $0 || text.rangeOfCharacterFromSet($1) != nil
        }
    }
}
