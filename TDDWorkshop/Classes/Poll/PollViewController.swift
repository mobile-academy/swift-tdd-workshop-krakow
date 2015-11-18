//
//  PollViewController.swift
//  TDD Workshop
//
//  Created by Maciej Oczko on 03.07.2015.
//  Copyright © 2015 Mobile Academy. All rights reserved.
//

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

    var pollManager: PollSender?
    var pollBuilder: PollBuilder?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        title = "Feedback"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureForm()
    }

    override func viewWillAppear(animated: Bool) {
        guard let pollManager = self.pollManager else {
            return
        }

        // Think what else could be tested for this class.
        self.navigationItem.rightBarButtonItem =
                pollManager.isPollAlreadySent()
                ? nil
                : UIBarButtonItem(title: "Send", style: .Plain, target: self, action: "didTapSend")

    }

    func didTapSend() {
        guard let pollBuilder = self.pollBuilder where pollBuilder.isValid() else {
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
        guard let pollManager = self.pollManager else {
            return
        }
        guard let pollBuilder = self.pollBuilder else {
            return
        }

        let poll = pollBuilder.poll()
        pollManager.sendPoll(poll) {
            [weak self] success, error in
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
                        if let pollBuilder = _self.pollBuilder where _self.validateText(row.value) {
                            pollBuilder.setName(row.value)
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
                        if let pollBuilder = _self.pollBuilder where _self.validateEmail(row.value) {
                            pollBuilder.setEmail(row.value)
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
                    if let pollBuilder = _self.pollBuilder where _self.validateComment(row.value) {
                        pollBuilder.setComments(row.value)
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
                        if let pollBuilder = self?.pollBuilder {
                            pollBuilder.setRate(symbols[🎉], forTitle: section)
                        }
                    }
                    .onChange {
                        [weak self] row in
                        guard let value = row.value else {
                            return
                        }
                        if let pollBuilder = self?.pollBuilder {
                            pollBuilder.setRate(symbols[value], forTitle: section)
                        }
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
                        if let pollBuilder = _self.pollBuilder where _self.validateComment(row.value) {
                            pollBuilder.setComment(row.value, forTitle: section)
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

    // TODO: Extract and test validation logic (to make it more reusable and reliable).
    // Hint 1: Create common Validator protocol
    // Hint 2: Create different validators (comment, email, etc.)
    // Hint 3: Create validators factory (remember about tests)
    // Hint 4: To simulate input on, e.g. 'name' form cell use this code:
    /*
        <this controller>.form.allRows.filter {
            $0.tag == "name"
        }.forEach {
            row in
            row.hightlightCell()
            row.baseValue = "<fixture string>"
            row.unhighlightCell()
        }
    */

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
