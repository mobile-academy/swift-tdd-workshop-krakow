//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit
import UIImage_Resize

protocol ImageManipulating {
    func scaleImage(image: UIImage, maxDimension: Int) -> UIImage

    func dataFromImage(image: UIImage, quality: Float) -> NSData
    func imageFromData(data: NSData) -> UIImage
}

class DefaultImageManipulator: ImageManipulating {

    func scaleImage(image: UIImage, maxDimension: Int) -> UIImage {
        let size = CGSize(width: maxDimension, height: maxDimension)
        return image.resizedImageToFitInSize(size, scaleIfSmaller: true)
    }

    func dataFromImage(image: UIImage, quality: Float) -> NSData {
        return UIImageJPEGRepresentation(image, CGFloat(quality))!
    }

    func imageFromData(data: NSData) -> UIImage {
        return UIImage(data: data)!
    }

}
