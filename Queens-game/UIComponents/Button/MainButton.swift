//
//  MainButton.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-16.
//

import UIKit


/// This is a main button. It is mainly used for positive or strong meaning such as "Next", "Yes", "Ok", and "Save".
class MainButton: QueensGameButton {
  
  /// Custom initializer to create Button
  /// - Parameters:
  ///   - superView: The view you want to set as super view. nil will be ignored.
  ///   - title: The title displayed in the button.
  init(superView: UIView? = nil, title: String = "Next") {
    super.init(frame: .zero)
    
    self.configLayout(
      bgColor: CustomColor.text,
      radius: 24
    )
    
    // Config lable
    self.titleLabel?.font = CustomFont.h4
    self.setTitle(title, for: .normal)
    self.titleLabel?.textAlignment = .center
    
    // Config color
    self.setTitleColor(CustomColor.background, for: .normal)
    
    self.contentEdgeInsets = contentInset

    // Button Icon
    self.insertIcon(
      IconFactory.createSystemIcon("chevron.right", color: CustomColor.background)!,
      to: .right
    )
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
