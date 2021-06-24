//
//  CloseButton.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-16.
//

import UIKit
class CloseButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    // Set image
    let image = IconFactory.createSystemIcon("xmark.circle.fill", pointSize: 20)

    self.setBackgroundImage(image, for: .normal)
    self.translatesAutoresizingMaskIntoConstraints = false
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

