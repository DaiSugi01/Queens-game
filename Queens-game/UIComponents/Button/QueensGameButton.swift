//
//  QueensGameButton.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-07-02.
//

import UIKit

/// Basic super class for button used in Queens gmae
class QueensGameButton: UIButton {

  /// where to put image
  enum Direction {
    case left, right
  }
  
  /// Basic inset of button
  var contentInset: UIEdgeInsets = .init(top: 16, left: 16, bottom: 16, right: 16)
  var paddingBetweenImageAndText: CGFloat = 8
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.translatesAutoresizingMaskIntoConstraints = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


// icon
extension QueensGameButton {
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


// highleted
extension QueensGameButton {
  // This will more work than setColor for .Highlighted
  override var isHighlighted: Bool {
    didSet {
      self.titleLabel?.alpha = isHighlighted ? 0.4 : 1
      self.imageView?.alpha = isHighlighted ? 0.4 : 1
    }
  }
}
