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
