//
//  CommandHeaderCollectionReusableView.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-10.
//

import UIKit

class CommandHeaderCollectionReusableView: UICollectionReusableView {
  static let identifier = "command header"
  
  let title = H2Label(text: "Title")
  let subTitle = H3Label(text: "Command list")
  
  lazy var stackView: VerticalStackView = {
    title.numberOfLines = 0
    let sv = VerticalStackView(
      arrangedSubviews: [title, subTitle],
      spacing: 24
    )
    sv.isLayoutMarginsRelativeArrangement = true
    sv.directionalLayoutMargins = .init(top: 76, leading: 0, bottom: 0, trailing: 0)
    return sv
  } ()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    stackView.configSuperView(under: self)
    stackView.matchParent()
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
  
}
