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
    let image = IconFactory.createSystemIcon("list.bullet", pointSize: 24)

    self.setBackgroundImage(image, for: .normal)
    self.translatesAutoresizingMaskIntoConstraints = false
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

