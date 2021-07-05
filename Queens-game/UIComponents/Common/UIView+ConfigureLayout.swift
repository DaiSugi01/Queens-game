//
//  UIView+configLayout.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-16.
//

import UIKit

extension UIView {
  
  
  /// Configure the layout of UIView.
  /// - Parameters:
  ///   - superView: This will be the super view if you refer. `nil` will ignore.
  ///   - width: Add width constraint. `nil` will ignore.
  ///   - height: Add height constraint. `nil` will ignore.
  ///   - bgColor: Set background color. `nil` will ignore.
  ///   - radius: Set corner Radius. `nil` will ignore.
  func configureLayout(
                    superView: UIView? = nil,
                    width: CGFloat? = nil,
                    height: CGFloat? = nil,
                    bgColor: UIColor? = nil,
                    radius: CGFloat? = nil
  ) {
    if let superView = superView { configureSuperView(under: superView) }
    configureSize(width: width, height: height)
    if let color = bgColor { configureBgColor(bgColor: color) }
    if let radius = radius { configureRadius(radius: radius) }
  }
  
  
  /// Set the super view.
  /// - Internally this will be `under.addSubview(self)`
  /// - Parameter under: The view you want to set as`superview`
  func configureSuperView(under: UIView) {
    under.addSubview(self)
    self.translatesAutoresizingMaskIntoConstraints = false
  }
  
  
  /// Set width and height constraint
  /// - Parameters:
  ///   - width: If it's nil, it won't set any constraint.  By default, it's nil.
  ///   - height: If it's nil, it won't set any constraint.  By default, it's nil.
  func configureSize(width: CGFloat? = nil, height: CGFloat? = nil) {
    if let width = width {
      self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    if let height = height {
      self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
  }
  
  
  /// Set background color of the view.
  /// - Parameter color:
  func configureBgColor(bgColor: UIColor) {
    self.backgroundColor = bgColor
  }
  
  
  /// Set corner radius.
  /// - Parameter radius: You should not set larger than min(width, height) of the view. It will collapse the shape.
  func configureRadius(radius: CGFloat) {
    self.layer.cornerRadius = radius
  }
  
}
