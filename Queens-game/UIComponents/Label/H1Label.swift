//
//  H1.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-16.
//

import UIKit

/// Custom label which font is h1 style
class H1Label: UILabel {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.font = CustomFont.h1
    self.textColor = CustomColor.main
    self.textAlignment = .left
    self.numberOfLines = 0
  }
  convenience init(text: String) {
    self.init(frame: .zero)
    self.text = text
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
