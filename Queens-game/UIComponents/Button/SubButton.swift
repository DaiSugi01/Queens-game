//
//  SubButton.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-17.
//

import UIKit

/// This is a sub button. It is mainly used for negative or weak meaning such as "Back", "No", "Cancel", and "Close".
class SubButton: UIButton {
  
  enum Direction {
    case left, right
  }
  
  var contentInset: UIEdgeInsets = .init(top: 16, left: 16, bottom: 16, right: 16)
  var paddingBetweenImageAndText: CGFloat = 8
  
  /// Custom initializer to create Button
  /// - Parameters:
  ///   - superView: The view you want to set as super view. nil will be ignored.
  ///   - title: The title displayed in the button.
  init(superView: UIView? = nil, title: String = "Back") {
    super.init(frame: .zero)

    self.configLayout(
      bgColor: CustomColor.background,
      radius: 24
    )
    
    // Config label
    self.titleLabel?.font = CustomFont.h4
    self.setTitle(title, for: .normal)
    self.titleLabel?.textAlignment = .center
    // Config color
    self.setTitleColor(CustomColor.main, for: .normal)
    self.setTitleColor(self.currentTitleColor.withAlphaComponent(0.8), for: .highlighted)
    
    // Config position of label.
    self.contentEdgeInsets = contentInset
    
    self.insertIcon(
      IconFactory.createSystemIcon("chevron.left")!,
      to: .left
    )
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func insertIcon(_ image: UIImage?, to: Direction) {
  
    self.setImage(image, for: .normal)
    self.setImage(image, for: .disabled) // This won't let change color at disable
    
    self.contentEdgeInsets.right += paddingBetweenImageAndText
    self.titleEdgeInsets = UIEdgeInsets(
        top: 0,
        left: paddingBetweenImageAndText,
        bottom: 0,
        right: -paddingBetweenImageAndText
    )
    
    switch to {
      case .left:
        self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        self.titleLabel?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        self.imageView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
      case .right:
        self.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        self.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        self.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
  }
  
  func moveIcon(to direction: Direction, withReverse: Bool) {
    guard let imageView = self.imageView, let image = imageView.image else { return }
    self.insertIcon(
      image,
      to: direction
    )
    if withReverse {
      imageView.transform = CGAffineTransform(scaleX: -imageView.transform.a, y: 1.0)
    }
  }
  
}
