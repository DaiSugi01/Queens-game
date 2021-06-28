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
    stackView.configSuperView(under: self)
    stackView.centerXYin(self)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    print("\(Self.self) is being deinitialized")
  }
}
