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

class PollViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feedback"
        configureForm()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .Plain, target: self, action: "sendPoll")
    }
    
    func sendPoll() {
        print("send poll")
    }
    
    func configureForm() {
        form +++ Section("General")
            <<<
            NameRow("name") {
                $0.title = "Name"
                $0.placeholder = "John Smith?"
            }
            <<<
            EmailRow("username") {
                $0.title = "E-mail"
                $0.placeholder = "you@example.com"
            }
            <<<
            TextAreaRow("feedback") {
                $0.title = "General feedback"
                $0.placeholder = "Write general feedback..."
        }
        form +++ Section("Intro")
            <<<
            SegmentedRow<Emoji>("rate1") {
                $0.title = "What's your rate?"
                $0.options = [🎉, 👍🏻, 😎, 👎🏻, 😡]
                $0.value = 🎉
            }
            <<<
            TextAreaRow("comment1") {
                $0.title = "Comments"
                $0.placeholder = "Write your comments here..."
        }
        form +++ Section("Testing techniques")
            <<<
            SegmentedRow<Emoji>("rate2") {
                $0.title = "What's your rate?"
                $0.options = [🎉, 👍🏻, 😎, 👎🏻, 😡]
                $0.value = 🎉
            }
            <<<
            TextAreaRow("comment2") {
                $0.title = "Comments"
                $0.placeholder = "Write your comments here..."
        }
        form +++ Section("Red Green Refactor")
            <<<
            SegmentedRow<Emoji>("rate3") {
                $0.title = "What's your rate?"
                $0.options = [🎉, 👍🏻, 😎, 👎🏻, 😡]
                $0.value = 🎉
            }
            <<<
            TextAreaRow("comment3") {
                $0.title = "Comments"
                $0.placeholder = "Write your comments here..."
        }
        form +++ Section("Working with Legacy Code")
            <<<
            SegmentedRow<Emoji>("rate4") {
                $0.title = "What's your rate?"
                $0.options = [🎉, 👍🏻, 😎, 👎🏻, 😡]
                $0.value = 🎉
            }
            <<<
            TextAreaRow("comment4") {
                $0.title = "Comments"
                $0.placeholder = "Write your comments here..."
        }
    }
}
