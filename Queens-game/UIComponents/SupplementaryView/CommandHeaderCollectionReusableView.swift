//
//  CommandHeaderCollectionReusableView.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-10.
//

import UIKit

class CommandHeaderCollectionReusableView: UICollectionReusableView {
  static let identifier = "command header"
  
  let title = H2Label(text: "Edit commands")
  let subTitle = H3Label(text: "Command list")
  
  lazy var stackView: VerticalStackView = {
    let uv = UIView()
    let sv = VerticalStackView(
      arrangedSubviews: [uv, title, subTitle]
    )
    sv.setCustomSpacing(64, after: uv)
    sv.setCustomSpacing(24, after: title)
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
