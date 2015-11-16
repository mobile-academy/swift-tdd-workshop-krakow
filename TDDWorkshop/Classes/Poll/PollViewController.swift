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
    var validatorFactory: ValidatorFactory?

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
                        let validator = self?.validatorFactory?.validatorForKey("name")
                        if let validator = validator where validator.validateText(row.value) {
                            self?.pollBuilder?.setName(row.value)
                        } else {
                            self?.showInvalidValueAlert(validator?.validationFailMessage())
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
                        let validator = self?.validatorFactory?.validatorForKey("username")
                        if let validator = validator where validator.validateText(row.value) {
                            self?.pollBuilder?.setEmail(row.value)
                        } else {
                            self?.showInvalidValueAlert(validator?.validationFailMessage())
                        }
                    }
                }
                <<<
                TextAreaRow("feedback") {
                    $0.title = "General feedback"
                    $0.placeholder = "Write general feedback..."
                }
                .onCellUnHighlight {
                    [weak self] (_, row) in
                    let validator = self?.validatorFactory?.validatorForKey("feedback")
                    if let validator = validator where validator.validateText(row.value) {
                        self?.pollBuilder?.setComments(row.value)
                    } else {
                        self?.showInvalidValueAlert(validator?.validationFailMessage())
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
                        self?.pollBuilder?.setRate(symbols[🎉], forTitle: section)
                    }
                    .onChange {
                        [weak self] row in
                        if let value = row.value {
                            self?.pollBuilder?.setRate(symbols[value], forTitle: section)
                        }
                    }
                    <<<
                    TextAreaRow("comment\(i)") {
                        $0.title = "Comments"
                        $0.placeholder = "Write your comments here..."
                    }
                    .onCellUnHighlight {
                        [weak self] (_, row) in
                        let validator = self?.validatorFactory?.validatorForKey("comment")
                        if let validator = validator where validator.validateText(row.value) {
                            self?.pollBuilder?.setComment(row.value, forTitle: section)
                        } else {
                            self?.showInvalidValueAlert(validator?.validationFailMessage())
                        }
                    }
        }
    }

    func showInvalidValueAlert(value: String?) {
        if let printableValue = value {
            let message = "Field value is incorrect: \"\(printableValue)\""
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
