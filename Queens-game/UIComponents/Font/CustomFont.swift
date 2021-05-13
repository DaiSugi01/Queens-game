//
//  CustomFont.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-16.
//

import UIKit


/// Custom font set used in this project.
struct CustomFont {
  static var h1: UIFont = {
    let f = UIFont.systemFont(ofSize: 64, weight: .black)
    return f
  }()
  static var h2: UIFont = {
    let f = UIFont.systemFont(ofSize: CGFloat(40), weight: .black)
    return f
  }()
  static var h3: UIFont = {
    let f = UIFont.systemFont(ofSize: 24, weight: .heavy)
    return f
  }()
  static var h4: UIFont = {
    let f = UIFont.systemFont(ofSize: 16, weight: .semibold)
    return f
  }()
  /// Regular font used in paragraph.
  static var p: UIFont = {
    let f = UIFont.systemFont(ofSize: 16, weight: .regular)
    return f
  }()
}
