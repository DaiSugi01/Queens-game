//
//  MainButton.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-16.
//

import UIKit


/// This is a main button. It is mainly used for positive or strong meaning such as "Next", "Yes", "Ok", and "Save".
class MainButton: UIButton {
  
  /// Custom initializer to create Button
  /// - Parameters:
  ///   - superView: The view you want to set as super view. nil will be ignored.
  ///   - title: The title displayed in the button.
  init(superView: UIView? = nil, title: String = "Next") {
    super.init(frame: .zero)

    self.configLayout(
      superView: superView,
      bgColor: CustomColor.main,
      radius: 24,
      shadow: true
    )
    
    // Config lable
    self.titleLabel?.font = CustomFont.h4
    self.setTitle(title, for: .normal)
    self.titleLabel?.textAlignment = .center
    
    // Config color
    self.setTitleColor(CustomColor.background, for: .normal)
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
