//
//  UIImage+Color.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-07-02.
//

import UIKit

extension UIImage {
  static func fromColor(_ color: UIColor) -> UIImage {
    let format = UIGraphicsImageRendererFormat()
     format.scale = 1
    let size = CGSize(width: 1, height: 1)
    let image =  UIGraphicsImageRenderer(size: size, format: format).image { rendererContext in
      color.setFill()
         rendererContext.fill(CGRect(origin: .zero, size: size))
    }
    return image
  }
}


//extension UIImage {
//  convenience init(color: UIColor, size: CGSize) {
//    UIGraphicsBeginImageContextWithOptions(size, false, 1)
//    color.set()
//    let ctx = UIGraphicsGetCurrentContext()!
//    ctx.fill(CGRect(origin: .zero, size: size))
//    let image = UIGraphicsGetImageFromCurrentImageContext()!
//    UIGraphicsEndImageContext()
//
//    self.init(data: image.pngData()!)!
//  }
//}
