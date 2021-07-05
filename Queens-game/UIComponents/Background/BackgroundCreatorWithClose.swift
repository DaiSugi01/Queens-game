//
//  BackgroundCreatorWithClose.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-16.
//

import UIKit


/// BackgroundView which also have close bottom on top right in addition to `backgroundPlain`
class BackgroundCreatorWithClose: BackgroundCreatorPlain {

  let closeButton = CloseButton()
  /// This is used for `present` and getting `view`
  weak var viewController: QueensGameViewControllerProtocol!
  
  init(viewController: QueensGameViewControllerProtocol) {
    super.init(parentView: viewController.view)
    self.viewController = viewController
  }
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func configureLayout() {
    closeButton.configureSuperView(under: parentView)
    super.configureLayout()
    configureCloseButton()
  }
  
  func configureCloseButton() {
    NSLayoutConstraint.activate([
      closeButton.centerYAnchor.constraint(
        equalTo: parentView.topAnchor,
        constant: Constant.Common.topLineHeight
      ),
      closeButton.trailingAnchor.constraint(
        equalTo: parentView.trailingAnchor,
        constant: -Constant.Common.trailingSpacing*0.8
      )
    ])
    closeButton.addTarget(
      self,
      action: #selector(closeTapped),
      for: .touchUpInside
    )
  }
  @objc func closeTapped() {
    viewController.dismiss(animated: true, completion: nil)
  }
  
  override func configureBorder() {
    // Top (Consider menu button)
    topLine.configureSuperView(under: parentView)
    NSLayoutConstraint.activate([
      topLine.leadingAnchor.constraint(
        equalTo: parentView.leadingAnchor,
        constant: Constant.Common.leadingSpacing
      ),
      topLine.centerYAnchor.constraint(
        equalTo: parentView.topAnchor,
        constant: Constant.Common.topLineHeight
      ),
      topLine.trailingAnchor.constraint(
        equalTo: closeButton.leadingAnchor,
        constant: -16
      )
    ])
    
    // Bottom (same)
    bottomLine.configureSuperView(under: parentView)
    NSLayoutConstraint.activate([
      bottomLine.widthAnchor.constraint(
        equalTo: parentView.widthAnchor,
        constant: -Constant.Common.leadingSpacing*2
      ),
      bottomLine.topAnchor.constraint(
        equalTo: parentView.bottomAnchor,
        constant: -Constant.Common.bottomLineHeight
      ),
      bottomLine.centerXAnchor.constraint(equalTo: parentView.centerXAnchor)
    ])
  }
}
