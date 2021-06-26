//
//  PlayerSelectionViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class PlayerSelectionViewController: UIViewController, QueensGameViewControllerProtocol {
  
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorWithMenu(viewController: self)
  
  enum Operation {
    case minus
    case plus
  }
  
  let vm = PlayerSelectionViewModel()
  
  var playerCount: Int = Constant.PlayerSelection.minPlayerCount
  
  lazy var verticalSV = VerticalStackView(
    arrangedSubviews: [screenTitle, plusMinusWrapper, navButtons],
    distribution: .equalSpacing
  )
  
  // Title
  let screenTitle = H2Label(text: "Choose max players")
  
  // plusMinusWrapper
  lazy var plusMinusWrapper: HorizontalStackView = {
    let sv = HorizontalStackView(arrangedSubviews: [minusButton, playerCountLabel, plusButton])
    sv.isLayoutMarginsRelativeArrangement = true
    sv.directionalLayoutMargins = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
    return sv
  }()
  
  let minusButton: UIButton = {
    let bt = UIButton()
    let btImage = IconFactory.createSystemIcon("minus.circle.fill", pointSize: 32)
    bt.setImage(btImage, for: .normal)
    bt.setContentHuggingPriority(.required, for: .horizontal)
    bt.addTarget(self, action: #selector(decrementPlayerCount(_:)), for: .touchUpInside)
    
    return bt
  }()
  @objc func decrementPlayerCount(_ sender: UIButton) {
    if !canChangePlayerCount(operation: .minus) { return }
    playerCount -= 1
    updateUI()
  }
  
  let playerCountLabel: H1Label = {
    let lb = H1Label(text: "\(Constant.PlayerSelection.minPlayerCount)")
    lb.numberOfLines = 0
    lb.textAlignment = .center
    
    return lb
  }()
  
  let plusButton: UIButton = {
    let bt = UIButton()
    let btImage = IconFactory.createSystemIcon("plus.circle.fill", pointSize: 32)
    bt.setImage(btImage, for: .normal)
    bt.setContentHuggingPriority(.required, for: .horizontal)
    bt.addTarget(self, action: #selector(incrementPlayerCount(_:)), for: .touchUpInside)
    
    return bt
  }()
  @objc func incrementPlayerCount(_ sender: UIButton) {
    if !canChangePlayerCount(operation: .plus) { return }
    playerCount += 1
    updateUI()
  }
  
  // nav Buttons
  let navButtons: NextAndBackButtons = {
    
    let bts = NextAndBackButtons()
    bts.nextButton.addTarget(self, action: #selector(goToNext(_:)), for: .touchUpInside)
    bts.backButton.addTarget(self, action: #selector(goBackToPrevious(_:)), for: .touchUpInside)
    
    return bts
  }()
  @objc func goToNext(_ sender: UIButton) {
    vm.initUserData(playerCount: playerCount)
    let nx = EntryNameViewController()
    GameManager.shared.pushGameProgress(navVC: navigationController,
                                        currentScreen: self,
                                        nextScreen: nx)
  }
  
  @objc func goBackToPrevious(_ sender: UIButton) {
    GameManager.shared.popGameProgress(navVC: navigationController)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
    backgroundCreator.configureLayout()
  }
  
  /// Setup whole layout
  private func setupLayout() {
    
    screenTitle.configSuperView(under: view)
    plusMinusWrapper.configSuperView(under: view)
    navButtons.configSuperView(under: view)

    screenTitle.anchors(
      topAnchor: view.topAnchor,
      leadingAnchor: view.leadingAnchor,
      trailingAnchor: view.trailingAnchor,
      bottomAnchor: nil,
      padding: .init(
        top: Constant.Common.topSpacing,
        left: Constant.Common.leadingSpacing + 8,
        bottom: 0,
        right: Constant.Common.trailingSpacing + 8
      )
    )
    
    plusMinusWrapper.centerXYin(view)
    
    navButtons.configureLayoutToBottom()

  }
  
  /// Check if the player number is valid or invalid
  /// - Parameter operation: minus or plus
  /// - Returns: true if the player number is  between the min number and max number, otherwise return false
  private func canChangePlayerCount(operation: Operation) -> Bool {
    switch operation {
      case .minus:
        return playerCount > Constant.PlayerSelection.minPlayerCount
      case .plus:
        return playerCount < Constant.PlayerSelection.maxPlayerCount
    }
  }
  
  /// Update player count label
  private func updateUI() {
    playerCountLabel.text = "\(playerCount)"
  }
}

extension PlayerSelectionViewController: UIViewControllerTransitioningDelegate {
  // Tells delegate What kind if animation transitioning do you want to use when presenting ?
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    print("aaaa")
    PopUpTransitioning.shared.presenting = true
    return PopUpTransitioning.shared
  }
  
  // Tells delegate What kind if animation transitioning do you want to use when dismissing ?
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    PopUpTransitioning.shared.presenting = false
    return PopUpTransitioning.shared
  }
}

