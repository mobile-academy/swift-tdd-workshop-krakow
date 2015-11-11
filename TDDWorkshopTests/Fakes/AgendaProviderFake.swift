//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

@testable
import TDDWorkshop

class AgendaProviderFake: AgendaProviding {

    var reloadAgendaCalled = false
    var completion: (() -> ())?

    func simulateSuccessfulReload(items: [AgendaItem]) {
        self.agendaItems = items
        self.completion?()
    }

    // MARK: AgendaProviding

    var agendaItems: [AgendaItem] = []

    func reloadAgenda(completion: () -> ()) {
        self.reloadAgendaCalled = true
        self.completion = completion
    }
}
