//
//  CustomColor.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-16.
//

import UIKit


/// Custom color set used for this project.
/// - Compatible with dark mode.
struct CustomColor {
  
  /// Used for main text color.
  /// - Light mode -> similar to  black color
  /// - Dark mode -> similar to white color
  static var main: UIColor {
    return UIColor { (traitCollection: UITraitCollection) -> UIColor in
      return traitCollection.userInterfaceStyle == .light ?
        UIColor(hex: "#1A1717")! : UIColor(hex: "#1A1717")!
    }
  }
  
  /// Used for sub-main text color. More subtle, gray-like color. We use this color when we slightly display some supplement info.
  /// - Light mode -> similar to  black color
  /// - Dark mode -> similar to white color
  static var subMain: UIColor {
    return UIColor { (traitCollection: UITraitCollection) -> UIColor in
      return traitCollection.userInterfaceStyle == .light ?
        UIColor(hex: "#8C8989")! : UIColor(hex: "#8C8989")!
    }
  }
  
  /// Used when we want to emphasis something.
  /// - Light mode -> similar to  red color
  /// - Dark mode -> similar to red color
  static var accent: UIColor {
    return UIColor { (traitCollection: UITraitCollection) -> UIColor in
      return traitCollection.userInterfaceStyle == .light ?
        UIColor(hex: "#CC3033")! : UIColor(hex: "#CC3033")!
    }
  }
  
  /// Used for background color.
  /// - Light mode -> similar to white
  /// - Dark mode -> similar to black
  static var background: UIColor {
    return UIColor { (traitCollection: UITraitCollection) -> UIColor in
      return traitCollection.userInterfaceStyle == .light ?
        UIColor(hex: "#F2EEE8")! : UIColor(hex: "#F2EEE8")!
    }
  }

  /// Used for background, but one level deeper (darker) than background. We use it when the object is concave, such as text field.  Imagine like this shape. -> ⌴
  /// - Light mode -> similar to white, but slightly darker.
  /// - Dark mode -> similar to black, but slightly darker
  static var concave: UIColor {
    return UIColor { (traitCollection: UITraitCollection) -> UIColor in
      return traitCollection.userInterfaceStyle == .light ?
        UIColor(hex: "#EBE5DA")! : UIColor(hex: "#EBE5DA")!
    }
  }
  
  /// Used for background, but one level shallow (lighter) than background. We use it when the object is convex, such as card and cell.  Imagine like this shape. -> ⎍
  /// - Light mode -> similar to white, but slightly lighter.
  /// - Dark mode -> similar to black, but slightly lighter.
  static var convex: UIColor {
    return UIColor { (traitCollection: UITraitCollection) -> UIColor in
      return traitCollection.userInterfaceStyle == .light ?
        UIColor(hex: "#FFFEFC")! : UIColor(hex: "#FFFEFC")!
    }
  }
}
