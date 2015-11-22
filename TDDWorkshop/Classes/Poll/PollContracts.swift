//
// Created by Maciej Oczko on 16.11.2015.
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

protocol PollSender {
    func isPollAlreadySent() -> Bool

    func sendPoll(poll: Poll, completion: ((Bool, NSError?) -> ())?)
}
