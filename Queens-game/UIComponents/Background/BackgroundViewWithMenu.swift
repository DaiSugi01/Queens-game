//
//  BackgroundViewWithMenu.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-13.
//

import UIKit


/// BackgroundView which also have menu bottom on top right in addition to `ackgroundViewPlain`
class BackgroundViewWithMenu: BackgroundViewPlain {
  
  let menuButton = MenuButton()
  /// This is used for `present` and getting `view`
  weak var viewController: UIViewController!
  
  init(viewController: UIViewController) {
    super.init(parentView: viewController.view)
    self.viewController = viewController
  }
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func configBackgroundLayout() {
    configMenuButton()
    super.configBackgroundLayout()
  }
  
  // Menu Button
  func configMenuButton() {
    // Config position.
    menuButton.configSuperView(under: self)
    NSLayoutConstraint.activate([
      menuButton.centerYAnchor.constraint(equalTo: self.topAnchor, constant: Constant.Common.topSpacing*0.5),
      menuButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constant.Common.trailingSpacing*0.8)
    ])
    menuButton.addTarget(self, action: #selector(menuTapped), for: .touchUpInside)
    menuButton.layer.zPosition = 9
  }
  @objc func menuTapped() {
    let nx = MenuViewController()
    viewController.present(nx, animated: true, completion: nil)
  }
  
  // Config border is changed because of menu bottom.
  override func configBorder() {
    // Config top position.
    topLine.configSuperView(under: self)
    NSLayoutConstraint.activate([
      topLine.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constant.Common.leadingSpacing),
      topLine.centerYAnchor.constraint(equalTo: self.topAnchor, constant: Constant.Common.topSpacing*0.5),
      topLine.trailingAnchor.constraint(equalTo: menuButton.leadingAnchor, constant: -16)
    ])
    
    // Config bottom position.
    bottomLine.configSuperView(under: self)
    NSLayoutConstraint.activate([
      bottomLine.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -Constant.Common.leadingSpacing*2),
      bottomLine.topAnchor.constraint(equalTo: self.bottomAnchor, constant: Constant.Common.bottomSpacing*0.5),
      bottomLine.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    ])
  }
}
