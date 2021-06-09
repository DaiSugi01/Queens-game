//
//  PlayerSelectionViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class PlayerSelectionViewController: UIViewController {
  
  enum Operation {
    case minus
    case plus
  }
  
  let vm = PlayerSelectionViewModel()
  
  var playerCount: Int = Constant.PlayerSelection.minPlayerCount
  
  lazy var verticalSV = VerticalStackView(arrangedSubviews: [screenTitle, horizontalSV, navButtons])
  
  let screenTitle: H2Label = {
    let lb = H2Label(text: "Choose max players")
    lb.lineBreakMode = .byWordWrapping
    lb.numberOfLines = 0
    lb.setContentHuggingPriority(.required, for: .vertical)
    
    return lb
  }()
  
  lazy var horizontalSV: HorizontalStackView = {
    let sv = HorizontalStackView(arrangedSubviews: [minusButton, playerCountLabel, plusButton])
    sv.isLayoutMarginsRelativeArrangement = true
    sv.directionalLayoutMargins = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
    return sv
  }()
  
  let minusButton: UIButton = {
    let bt = UIButton()
    let imgConfig = UIImage.SymbolConfiguration(pointSize: 32, weight: .bold, scale: .large)
    let btImage = UIImage(systemName: "minus.circle.fill", withConfiguration: imgConfig)?
      .withTintColor(CustomColor.main, renderingMode: .alwaysOriginal)
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
    let imgConfig = UIImage.SymbolConfiguration(pointSize: 32, weight: .bold, scale: .large)
    let btImage = UIImage(systemName: "plus.circle.fill", withConfiguration: imgConfig)?
      .withTintColor(CustomColor.main, renderingMode: .alwaysOriginal)
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
  }
  
  /// Setup whole layout
  private func setupLayout() {
    // config navigation
    navigationItem.hidesBackButton = true
    
    // add components to super view
    view.backgroundColor = CustomColor.background
    
    verticalSV.configSuperView(under: view)
    verticalSV.anchors(
      topAnchor: view.topAnchor,
      leadingAnchor: view.leadingAnchor,
      trailingAnchor: view.trailingAnchor,
      bottomAnchor: view.bottomAnchor,
      padding: .init(
        top: Constant.Common.topSpacing,
        left: Constant.Common.leadingSpacing,
        bottom: -Constant.Common.bottomSpacing,
        right: -Constant.Common.trailingSpacing
      )
    )
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
