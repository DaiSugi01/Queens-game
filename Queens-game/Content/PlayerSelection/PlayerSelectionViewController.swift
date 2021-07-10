//
//  PlayerSelectionViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit
import RxSwift
import RxCocoa


class PlayerSelectionViewController: UIViewController, QueensGameViewControllerProtocol {
  
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorWithMenu(viewController: self)
  
  private let vm = PlayerSelectionViewModel()

  // All
  private lazy var verticalSV = VerticalStackView(
    arrangedSubviews: [screenTitle, plusMinusWrapper, navButtons],
    distribution: .equalSpacing
  )
  
  // Title
  private let screenTitle = H2Label(text: "How many players?")
  
  
  // minus
  private let minusButton: QueensGameButton = {
    let bt = QueensGameButton()
    let btImage = IconFactory.createSystemIcon(
      "person.crop.circle.badge.minus",
      color: CustomColor.subText,
      pointSize: 40,
      weight: .regular
    )
    let btImageDisabled = IconFactory.createSystemIcon(
      "person.crop.circle.badge.minus",
      color: CustomColor.accent.withAlphaComponent(0.1),
      pointSize: 40,
      weight: .regular
    )
    bt.setImage(btImage, for: .normal)
    bt.setImage(btImageDisabled, for: .disabled)
    bt.setContentHuggingPriority(.required, for: .horizontal)
    return bt
  }()
  
  // #player
  private let playerCountLabel: H1Label = {
    let lb = H1Label()
    lb.textAlignment = .center
    return lb
  }()
  
  // plus
  private let plusButton: QueensGameButton = {
    let bt = QueensGameButton()
    let btImage = IconFactory.createSystemIcon(
      "person.crop.circle.fill.badge.plus",
      color: CustomColor.subText,
      pointSize: 40,
      weight: .regular
    )
    let btImageDisabled = IconFactory.createSystemIcon(
      "person.crop.circle.fill.badge.plus",
      color: CustomColor.accent.withAlphaComponent(0.1),
      pointSize: 40,
      weight: .regular
    )
    bt.setImage(btImage, for: .normal)
    bt.setImage(btImageDisabled, for: .disabled)
    bt.setContentHuggingPriority(.required, for: .horizontal)
    return bt
  }()
  
  // wrapper
  private lazy var plusMinusWrapper: HorizontalStackView = {
    let sv = HorizontalStackView(
      arrangedSubviews: [minusButton, playerCountLabel, plusButton],
      distribution: .equalSpacing
    )
    sv.isLayoutMarginsRelativeArrangement = true
    sv.directionalLayoutMargins = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
    
    return sv
  }()
  
  // nav Buttons
  private let navButtons: NextAndBackButtons = NextAndBackButtons()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureLayout()
    // This comes lastly at layout settings to add menu button in top layer.
    backgroundCreator.configureLayout()
    
    configurePlayerCountBinding()
    configureNavButtonBinding()
  }
}


// MARK: - Layout

extension PlayerSelectionViewController {
  
  /// Setup whole layout
  private func configureLayout() {
    
    screenTitle.configureSuperView(under: view)
    plusMinusWrapper.configureSuperView(under: view)
    navButtons.configureSuperView(under: view)
    
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
    plusMinusWrapper.widthAnchor.constraint(
      equalTo: view.widthAnchor,
      multiplier: 1,
      constant: -Constant.Common.leadingSpacing*2
    ).isActive = true
    
    navButtons.configureLayoutToBottom()
    
  }
  
}


// MARK: - Bindings

extension PlayerSelectionViewController {
  
  private func configureNavButtonBinding() {
    navButtons.nextButton.rx.tap
      .bind{ [weak self] in
        guard let self = self else { return }
        
        self.vm.initUserData(playerCount: self.vm.numOfPlayers.value)
        let nx = EntryNameViewController()
        GameManager.shared.pushGameProgress(
          navVC: self.navigationController,
          currentScreen: self,
          nextScreen: nx
        )
      }
      .disposed(by: vm.disposeBag)
    
    navButtons.backButton.rx.tap
      .bind{ [weak self] in
        guard let self = self else { return }
        GameManager.shared.popGameProgress(navVC: self.navigationController)
      }
      .disposed(by: vm.disposeBag)
  }
  
  private func configurePlayerCountBinding() {
    // button tapped -> #player
    plusButton.rx.tap
      .subscribe { [weak self] _ in
        self?.vm.numOfPlayers.accept((self?.vm.numOfPlayers.value)! + 1)
      }
      .disposed(by: vm.disposeBag)
    
    minusButton.rx.tap
      .subscribe { [weak self] _ in
        self?.vm.numOfPlayers.accept((self?.vm.numOfPlayers.value)! - 1)
      }
      .disposed(by: vm.disposeBag)
    
    // #player -> UI
    vm.numOfPlayers
      .map{String($0)}
      .bind(to: playerCountLabel.rx.text)
      .disposed(by: vm.disposeBag)
    
    vm.numOfPlayers
      .map {$0 < Constant.PlayerSelection.maxPlayerCount }
      .bind(to: plusButton.rx.isEnabled)
      .disposed(by: vm.disposeBag)
    
    vm.numOfPlayers
      .map {$0 > Constant.PlayerSelection.minPlayerCount }
      .bind(to: minusButton.rx.isEnabled)
      .disposed(by: vm.disposeBag)
  }

}
