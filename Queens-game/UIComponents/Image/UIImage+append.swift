//
//  UIImage+merge.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-28.
//

import UIKit

extension UIImage {
  /// Helper enum used in [append](x-source-tag://append) function in UIImage. This must no be used outer UIImage.
  enum Direction {
    case top, left, right, bottom
  }

  /// Append  an image to current image, and export as new combined image. This will not change original image.
  /// - Parameters:
  ///   - secondImage: An image you want to append. Ideally, same size of image is preferred.
  ///   - to: Direction that you want to add. You can add second Image to top, left, right, and bottom.
  /// - Returns: New UIImage.
  /// - Tag: append
  func append(image secondImage: UIImage, to: Direction) -> UIImage {
    
    // Get first image coordinates
    let firstImage = self
    let fw = firstImage.size.width
    let fh = firstImage.size.height
    var firstX: CGFloat = 0
    var firstY: CGFloat = 0

    // Get second image coordinates
    var secondX: CGFloat = 0
    var secondY: CGFloat = 0
    let sw = secondImage.size.width
    let sh = secondImage.size.height
    
    // Adjust each coordinates based on the adding direction.
    let mergedSize: CGSize
    switch to {
      case .top:
        mergedSize = CGSize(width: max(fw, sw), height: fh + sh)
        firstY += sh
      case .left:
        mergedSize = CGSize(width: fw + sw, height: max(fh, sh))
        firstX += sw
      case .right:
        mergedSize = CGSize(width: fw + sw, height: max(fh, sh))
        secondX += fw
      case .bottom:
        mergedSize = CGSize(width: max(fw, sw), height: fh + sh)
        secondY += fh
    }
    let firstSize = CGRect(x: firstX, y: firstY, width: fw, height: fh)
    let secondSize = CGRect(x: secondX,  y: secondY , width: sw, height: sh)
    
    // Combine two images.
    UIGraphicsBeginImageContextWithOptions(mergedSize, false, 0) // This `Scale 0` is required! Otherwise the new image will be blurred.
    firstImage.draw(in: firstSize)
    secondImage.draw(in: secondSize)
    let mergedImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return mergedImage
  }
}
