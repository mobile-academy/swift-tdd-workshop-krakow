//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

@testable
import TDDWorkshop

class ImageManipulatorFake: ImageManipulating {

    var capturedImageToScale: UIImage?
    var capturedImageToDataConversion: UIImage?

    var fakeDataFromImage: NSData = NSData()
    var fakeImageFromData: UIImage = UIImage()
    var fakeScaledImage: UIImage = UIImage()

    func scaleImage(image: UIImage, maxDimension: Int) -> UIImage {
        capturedImageToScale = image
        return fakeScaledImage
    }

    func dataFromImage(image: UIImage, quality: Float) -> NSData {
        capturedImageToDataConversion = image
        return fakeDataFromImage
    }

    func imageFromData(data: NSData) -> UIImage {
        return fakeImageFromData
    }

}
