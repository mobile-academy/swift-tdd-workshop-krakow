//
//  Copyright © 2015 Mobile Academy. All rights reserved.
//


import UIKit

class AgendaViewController: UITableViewController {

    var agendaProvider: AgendaProviding!

    // MARK: Initialisers
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        self.agendaProvider = AgendaProvider()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.agendaProvider = AgendaProvider()
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: reload agenda
    }

    // MARK: Table view
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(AgendaItemCellIdentifier, forIndexPath: indexPath) as! AgendaItemCell
        return cell;
    }
}
