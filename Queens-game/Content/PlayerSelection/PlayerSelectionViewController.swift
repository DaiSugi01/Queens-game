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
  
  lazy var verticalSV: VerticalStackView = {
    let sv = VerticalStackView(arrangedSubviews: [screenTitle, horizontalSV])
    sv.alignment = .fill
    sv.distribution = .equalSpacing
    sv.translatesAutoresizingMaskIntoConstraints = false
    
    return sv
  }()

  let screenTitle: H2Label = {
    let lb = H2Label(text: "Choose max players")
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.lineBreakMode = .byWordWrapping
    lb.numberOfLines = 0
    lb.setContentHuggingPriority(.required, for: .vertical)
    
    return lb
  }()

  lazy var horizontalSV: HorizontalStackView = {
    let sv = HorizontalStackView(arrangedSubviews: [minusButton, playerCountLabel, plusButton])
    sv.alignment = .fill
    sv.distribution = .fillEqually
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.constraintHeight(equalToConstant: 360)
    
    return sv
  }()
  
  let minusButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("-", for: .normal)
    bt.setTitleColor(CustomColor.main, for: .normal)
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
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.numberOfLines = 0
    lb.textAlignment = .center
    
    return lb
  }()

  let plusButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("+", for: .normal)
    bt.setTitleColor(CustomColor.main, for: .normal)
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
    let nx = EntryNameViewController(collectionViewLayout: UICollectionViewFlowLayout())
    GameManager.shared.pushGameProgress(navVC: navigationController!,
                                        currentScreen: self,
                                        nextScreen: nx)
  }

  @objc func goBackToPrevious(_ sender: UIButton) {
    GameManager.shared.popGameProgress(navVC: navigationController!)
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
    view.addSubview(verticalSV)
    view.addSubview(navButtons)
    
    // set constraints
    verticalSV.topAnchor.constraint(equalTo: view.topAnchor,
                                    constant: Constant.Common.topSpacing).isActive = true
    verticalSV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                        constant: Constant.Common.leadingSpacing).isActive = true
    verticalSV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                         constant:  Constant.Common.trailingSpacing).isActive = true
    
    navButtons.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                       constant: Constant.Common.bottomSpacing).isActive = true
    navButtons.centerXin(view)
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
