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
  ///   - shadow: Set shadow. `nil` will ignore.
  func configLayout(
                    superView: UIView? = nil,
                    width: CGFloat? = nil,
                    height: CGFloat? = nil,
                    bgColor: UIColor? = nil,
                    radius: CGFloat? = nil,
                    shadow: Bool? = nil
  ) {
    if let superView = superView { configSuperView(under: superView) }
    configSize(width: width, height: height)
    if let color = bgColor { configBgColor(bgColor: color) }
    if let radius = radius { configRadius(radius: radius) }
    if let shadow = shadow { configShadow(on: shadow) }
  }
  
  
  /// Set the super view.
  /// - Internally this will be `under.addSubview(self)`
  /// - Parameter under: The view you want to set as`superview`
  func configSuperView(under: UIView) {
    under.addSubview(self)
    self.translatesAutoresizingMaskIntoConstraints = false
  }
  
  
  /// Set width and height constraint
  /// - Parameters:
  ///   - width: If it's nil, it won't set any constraint.  By default, it's nil.
  ///   - height: If it's nil, it won't set any constraint.  By default, it's nil.
  func configSize(width: CGFloat? = nil, height: CGFloat? = nil) {
    if let width = width {
      self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    if let height = height {
      self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
  }
  
  
  /// Set background color of the view.
  /// - Parameter color:
  func configBgColor(bgColor: UIColor) {
    self.backgroundColor = bgColor
  }
  
  
  /// Set corner radius.
  /// - Parameter radius: You should not set larger than min(width, height) of the view. It will collapse the shape.
  func configRadius(radius: CGFloat) {
    self.layer.cornerRadius = radius
  }
  
  
  // FIXME: - if you set shadow, the view will be blurred. Fix it.
  /// Set drop shadow of the view
  /// - Parameter on: If true, set shadow. If false, don't set shadow.
  func configShadow(on: Bool) {
//    if !on {
//      self.layer.shadowOpacity = 0.0
//      return
//    }
//    self.layer.shouldRasterize = true
//    self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//    self.layer.shadowColor = CustomColor.main.cgColor
//    self.layer.shadowOpacity = 1
//    self.layer.shadowOffset = .zero
//    self.layer.shadowRadius = 10
    // https://www.hackingwithswift.com/articles/155/advanced-uiview-shadow-effects-using-shadowpath
  }
  
}
