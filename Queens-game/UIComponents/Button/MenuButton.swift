//
//  MenuButton.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-09.
//

import UIKit

class MenuButton: QueensGameButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    // Set image
    let image = IconFactory.createSystemIcon(
      "list.bullet",
      color: CustomColor.subMain,
      pointSize: 24
    )

    self.setImage(image, for: .normal)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

