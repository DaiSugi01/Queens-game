//
//  UIColor+Hex.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-16.
//

import UIKit

extension UIColor {
  
  /// Init color by hex. Convenience init created in extension
  /// - Parameter hex: Hex style color. Eg, "#1A1717"
  public convenience init?(hex: String) {
    let hex = hex.lowercased()
    let r, g, b, a: CGFloat
    if hex.hasPrefix("#") {
      
      let start = hex.index(hex.startIndex, offsetBy: 1)
      var hexColor = String(hex[start...])
      
      if hexColor.count == 6 {
        hexColor += "ff"
      }
      if hexColor.count == 8 {
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
          r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
          g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
          b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
          a = CGFloat(hexNumber & 0x000000ff) / 255
          
          self.init(red: r, green: g, blue: b, alpha: a)
          return
        }
      }
    }
    
    return nil
  }
}
