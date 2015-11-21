//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

protocol AgendaProviding {
    var agendaItems: [AgendaItem] { get }

    func reloadAgenda(completion: () -> ())
}

class AgendaProvider: AgendaProviding {

    var agendaItems: [AgendaItem] = []

    func reloadAgenda(completion: () -> ()) {
        dispatch_async(dispatch_get_global_queue(2, 0)) {
            self.agendaItems = [
                    AgendaItem(time: "10:00", name: "Introduction"),
                    AgendaItem(time: "11:30", name: "Coffee Break"),
                    AgendaItem(time: "11:45", name: "Testing Techniques"),
                    AgendaItem(time: "13:15", name: "Lunch"),
                    AgendaItem(time: "14:15", name: "Red Green Refactor"),
                    AgendaItem(time: "15:45", name: "Coffee Break"),
                    AgendaItem(time: "16:00", name: "Legacy Code"),
            ]

            dispatch_async(dispatch_get_main_queue(), completion)
        }
    }
}
