//
//  MenuButton.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-09.
//

import UIKit

class MenuButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    // Set image
    let imgConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .black, scale: .large)
    let image = UIImage(
      systemName: "list.dash" ,
      withConfiguration: imgConfig
    )? // change color
    .withTintColor(CustomColor.main, renderingMode: .alwaysOriginal)

    self.setBackgroundImage(image, for: .normal)
    self.translatesAutoresizingMaskIntoConstraints = false
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

