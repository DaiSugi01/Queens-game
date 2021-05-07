//
//  SubButton.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-17.
//

import UIKit

/// This is a sub button. It is mainly used for negative or weak meaning such as "Back", "No", "Cancel", and "Close".
class SubButton: UIButton {
  
  /// Custom initializer to create Button
  /// - Parameters:
  ///   - superView: The view you want to set as super view. nil will be ignored.
  ///   - title: The title displayed in the button.
  init(superView: UIView? = nil, title: String = "Back") {
    super.init(frame: .zero)

    self.configLayout(
      superView: superview,
      bgColor: .clear,
      radius: 24,
      shadow: false
    )
    
    // Config label
    self.titleLabel?.font = CustomFont.h3
    self.setTitle(title, for: .normal)
    self.titleLabel?.textAlignment = .center
    // Config color
    self.setTitleColor(CustomColor.main, for: .normal)
    self.setTitleColor(self.currentTitleColor.withAlphaComponent(0.8), for: .highlighted)
    
    // Config position of label.
    // There is no fix size for button, but always keeps +16 margin from label.
    let margin: CGFloat = -16
    self.anchors(
      topAnchor: self.titleLabel?.topAnchor,
      leadingAnchor: self.titleLabel?.leadingAnchor,
      trailingAnchor: self.titleLabel?.trailingAnchor,
      bottomAnchor: self.titleLabel?.bottomAnchor,
      padding: .init(top: margin, left: margin, bottom: margin , right: margin)
    )
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
