//
//  BackgroundCreatorWithClose.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-16.
//

import UIKit
import RxSwift

/// BackgroundView which also have close bottom on top right in addition to `backgroundPlain`
class BackgroundCreatorWithClose: BackgroundCreatorPlain {
  
  let disposeBag = DisposeBag()

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
    configureNavButtonBinding()
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

extension BackgroundCreatorWithClose {
  private func configureNavButtonBinding() {
   closeButton.rx.tap
      .bind{ [weak self] in
        self?.viewController.dismiss(animated: true, completion: nil)
      }
      .disposed(by: disposeBag)
  }
}
