//
//  Copyright © 2015 Mobile Academy. All rights reserved.
//

import UIKit

let AgendaItemCellIdentifier = "AgendaItemCellIdentifier"

class AgendaItemCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
