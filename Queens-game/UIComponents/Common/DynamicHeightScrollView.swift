//
//  DynamicHeightScrollView.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-17.
//

import UIKit

class DynamicHeightScrollView: UIScrollView {
  
  var contentView: UIView?
  
  init(contentView: UIView, padding: UIEdgeInsets = .zero) {
    self.contentView = contentView
    super.init(frame: .zero)
    
    self.translatesAutoresizingMaskIntoConstraints = false
    configureContentView(padding)
  }
  
  init() {
    self.contentView = nil
    super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureContentView(_ inset: UIEdgeInsets) {
    guard let contentView = contentView else { return }
    self.addSubview(contentView)
    
    // This will set the content  view's width
    contentView.widthAnchor.constraint(
      equalTo: self.widthAnchor,
      multiplier: 1,
      constant: -(inset.left + inset.right)
    ).isActive = true
    
    // This will create scroll view's `contentSize` equal to content view.
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor, constant: inset.top),
      contentView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor, constant: inset.left),
    ])
    contentView.anchors(
      topAnchor: contentLayoutGuide.topAnchor,
      leadingAnchor: contentLayoutGuide.leadingAnchor,
      trailingAnchor: contentLayoutGuide.trailingAnchor,
      bottomAnchor: contentLayoutGuide.bottomAnchor,
      padding: .init(
        top: inset.top,
        left: inset.left,
        bottom: inset.bottom,
        right: inset.right
      )
    )
  }
}

