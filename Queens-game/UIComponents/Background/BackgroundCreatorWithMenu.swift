//
//  BackgroundViewWithMenu.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-13.
//

import UIKit


/// BackgroundView which also have menu bottom on top right in addition to `backgroundPlain`
class BackgroundCreatorWithMenu: BackgroundCreatorPlain {

  let menuButton = MenuButton()
  private let popUpTransition = PopUpTransitioningDelegatee()
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
    menuButton.configSuperView(under: parentView)
    super.configureLayout()
    configureMenuButton()
  }
  
  func configureMenuButton() {
    NSLayoutConstraint.activate([
      menuButton.centerYAnchor.constraint(
        equalTo: parentView.topAnchor,
        constant: Constant.Common.topLineHeight
      ),
      menuButton.trailingAnchor.constraint(
        equalTo: parentView.trailingAnchor,
        constant: -Constant.Common.trailingSpacing*0.8
      )
    ])
    menuButton.addTarget(
      self,
      action: #selector(menuTapped),
      for: .touchUpInside
    )
  }
  @objc func menuTapped() {
    let nx = MenuViewController()
    
    nx.modalPresentationStyle = .overCurrentContext
    nx.transitioningDelegate = popUpTransition
    
    // If already something is presented, present the view over it
    if let presentedVC = viewController.presentedViewController {
        presentedVC.present(nx, animated: true, completion: nil)
    }else{
      viewController.present(nx, animated: true, completion: nil)
    }
  }
  
  override func configureBorder() {
    // Top (Consider menu button)
    topLine.configSuperView(under: parentView)
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
        equalTo: menuButton.leadingAnchor,
        constant: -16
      )
    ])
    
    // Bottom (same)
    bottomLine.configSuperView(under: parentView)
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



