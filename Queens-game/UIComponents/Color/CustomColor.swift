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
  static var text: UIColor {
    return UIColor { (traitCollection: UITraitCollection) -> UIColor in
      return traitCollection.userInterfaceStyle == .light ?
        UIColor(hex: "#251F1F")! : UIColor(hex: "#E1DFDF")!
    }
  }
  
  /// Used for sub-text color. More subtle, gray-like color. We use this color when we slightly display some supplement info.
  /// - Light mode -> similar to  black color
  /// - Dark mode -> similar to white color
  static var subText: UIColor {
    return UIColor { (traitCollection: UITraitCollection) -> UIColor in
      return traitCollection.userInterfaceStyle == .light ?
        UIColor(hex: "#968D8D")! : UIColor(hex: "#A09898")!
    }
  }
  
  /// Used when we want to emphasis something.
  /// - Light mode -> similar to  red color
  /// - Dark mode -> similar to red color
  static var accent: UIColor {
    return UIColor { (traitCollection: UITraitCollection) -> UIColor in
      return traitCollection.userInterfaceStyle == .light ?
        UIColor(hex: "#B83234")! : UIColor(hex: "#B83234")!
    }
  }
  
  /// Used for background color.
  /// - Light mode -> similar to white
  /// - Dark mode -> similar to black
  static var background: UIColor {
    return UIColor { (traitCollection: UITraitCollection) -> UIColor in
      return traitCollection.userInterfaceStyle == .light ?
        UIColor(hex: "#F3F2F2")! : UIColor(hex: "#0D0A0A")!
    }
  }

  /// Used for background, but one level deeper (darker) than background. We use it when the object is concave, such as text field.  Imagine like this shape. -> ⌴
  /// - Light mode -> similar to white, but slightly darker.
  /// - Dark mode -> similar to black, but slightly lighter
  static var backgroundLower: UIColor {
    return UIColor { (traitCollection: UITraitCollection) -> UIColor in
      return traitCollection.userInterfaceStyle == .light ?
        UIColor(hex: "#E7E5E4")! : UIColor(hex: "#191515")!
    }
  }
  
  /// Used for background, but one level shallow (lighter) than background. We use it when the object is convex, such as card and cell.  Imagine like this shape. -> ⎍
  /// - Light mode -> similar to white, but slightly lighter.
  /// - Dark mode -> similar to black, but slightly lighter.
  static var backgroundUpper: UIColor {
    return UIColor { (traitCollection: UITraitCollection) -> UIColor in
      return traitCollection.userInterfaceStyle == .light ?
        UIColor(hex: "#FFFFFF")! : UIColor(hex: "#242020")! //1C1919
    }
  }
}
