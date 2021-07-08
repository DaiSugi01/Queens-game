//
//  BackgroundImage.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-07-02.
//

import UIKit

struct BackgroundImage {
  static let image: UIImage = {
    //Because image is static, we implicitly set color by resolvedColor
    
    // Light image has texture
    let img = UIImage(named: "background-texture")
    let lightImage = UIImage.blend(
      CustomColor.background.resolvedColor(with: .init(userInterfaceStyle: .light)),
      img!
    )
    // Dark is simple no texture
    let darkImage = UIImage.fromColor(
      CustomColor.background.resolvedColor(with: .init(userInterfaceStyle: .dark))
    )
    
    let bgImage = UIImage.fromColor(.clear)
    // Register your light and dark mode image to image's asset.
    bgImage.imageAsset?.register(lightImage, with: .init(userInterfaceStyle: .light))
    bgImage.imageAsset?.register(darkImage, with: .init(userInterfaceStyle: .dark))
    return bgImage
  }()
}

