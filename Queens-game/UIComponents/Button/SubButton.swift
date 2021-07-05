//
//  SubButton.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-17.
//

import UIKit

/// This is a sub button. It is mainly used for negative or weak meaning such as "Back", "No", "Cancel", and "Close".
class SubButton: QueensGameButton {
  
  /// Custom initializer to create Button
  /// - Parameters:
  ///   - superView: The view you want to set as super view. nil will be ignored.
  ///   - title: The title displayed in the button.
  init(superView: UIView? = nil, title: String = "Back") {
    super.init(frame: .zero)

    self.configureLayout(
      bgColor: CustomColor.background,
      radius: 24
    )
    
    // Config label
    self.titleLabel?.font = CustomFont.h4
    self.setTitle(title, for: .normal)
    self.titleLabel?.textAlignment = .center
    
    // Config color
    self.setTitleColor(CustomColor.text, for: .normal)
    
    self.contentEdgeInsets = contentInset
    
    // button icon
    self.insertIcon(
      IconFactory.createSystemIcon("chevron.left")!,
      to: .left
    )
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
