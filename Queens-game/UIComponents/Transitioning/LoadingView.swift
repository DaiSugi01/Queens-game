//
//  LoadingView.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-27.
//

import UIKit

class LoadingView: UIView {
  let icon = UIImageView(image: IconFactory.createSystemIcon("livephoto", pointSize: 40))
  let label = H2Label(text: "Loading...")
  
  private lazy var stackView = VerticalStackView(
    arrangedSubviews: [icon, label],
    spacing: 24,
    alignment: .center,
    distribution: .equalSpacing
  )
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    self.backgroundColor = CustomColor.background
    label.textAlignment = .center
    stackView.configureSuperView(under: self)
    stackView.centerXYin(self)
    stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1, constant: -Constant.Common.leadingSpacing*2).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    print("\(Self.self) is being deinitialized")
  }
}
