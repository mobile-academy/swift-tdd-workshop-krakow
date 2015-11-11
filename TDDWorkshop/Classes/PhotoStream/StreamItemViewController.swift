//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class StreamItemViewController: UIViewController {
    
    //MARK: Properties
    
    var streamItem: StreamItem?
    var imageManipulator: ImageManipulating
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: Object life cycle
    
    required init?(coder: NSCoder) {
        imageManipulator = DefaultImageManipulator()
        super.init(coder: coder)
    }
    
    //MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = streamItem {
            imageView.image = imageManipulator.imageFromData(item.imageData)
        }
    }

    //MARK: Actions
    
    @IBAction func cancelBarButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) {}
    }
}
