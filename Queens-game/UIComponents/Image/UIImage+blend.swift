//
//  UIImage+blend.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-10.
//

import UIKit

extension UIImage {
  static func blend(_ color: UIColor, _ image: UIImage) -> UIImage {
    
    let imageRect = CGRect(origin: .zero, size: image.size)
    let colorRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
    let renderer = UIGraphicsImageRenderer(size: image.size)

      let tintedImage = renderer.image { context in
          color.set()
          context.fill(colorRect)
        image.draw(in: imageRect, blendMode: .luminosity, alpha: 0.6)
      }

      return tintedImage
  }
}

