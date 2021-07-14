//
//  QueenSelectedViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit
import RxSwift
import RxCocoa

class QueenSelectedViewController: UIViewController, QueensGameViewControllerProtocol {
  
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorPlain(parentView: view)
  
  private let disposeBag = DisposeBag()
  private let viewModel = QueenSelectedViewModel()
  
  // MARK: - Before countdown views
  
  private lazy var countdownStackView = CountdownStackView(
    countdown: viewModel.countdownTime
  )
  
  private let beforeCountdownTitle: H2Label = {
    let lb = H2Label(text: "Choosing a Queen...")
    lb.textAlignment = .center
    return lb
  }()
  
  private let skipButton: SubButton = {
    let button = SubButton()
    button.setTitle("Skip", for: .normal)
    button.insertIcon(IconFactory.createSystemIcon("chevron.right.2", weight: .bold), to: .right)
    return button
  }()
  
  
  private lazy var beforeCountdownStackView: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [
        beforeCountdownTitle,
        countdownStackView,
        skipButton
      ]
    )
    sv.alignment = .center
    sv.distribution = .equalSpacing
    return sv
  }()
  
  
  // MARK: After Countdown views
  
  private let afterCountdownTitle = H2Label(text: "The Queen is")
  
  private lazy var queenIcon: UIImageView = {
    let icon = IconFactory.createImageView(
      type: .queen,
      height: 152
    )
    return icon
  }()
  
  private lazy var userNumberLabel: H2Label = {
    let label = H2Label(text: "No.")
    label.textColor = CustomColor.accent
    label.textAlignment = .right
    return label
  }()
  
  private lazy var targetUserIcon: UIImageView = {
    let icon = IconFactory.createImageView(
      type: .userId(GameManager.shared.queen!.playerId),
      width: 64
    ) as! UserIdIconView
    return icon
  }()
  
  private lazy var targetUserName: H2Label = {
    let label = H2Label(text: GameManager.shared.queen!.name)
    label.textAlignment = .center
    label.textColor = CustomColor.accent
    return label
  }()
  
  private lazy var targetIconLabel: HorizontalStackView = {
    let sv = HorizontalStackView(
      arrangedSubviews: [self.userNumberLabel, targetUserIcon]
    )
    sv.distribution = .equalSpacing
    sv.alignment = .center
    sv.spacing = 16
    sv.setContentHuggingPriority(.required, for: .vertical)
    return sv
  }()
  
  private lazy var queenIconLabel: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [queenIcon, targetIconLabel, targetUserName]
    )
    sv.alignment = .center
    sv.spacing = 24
    sv.isLayoutMarginsRelativeArrangement = true
    sv.directionalLayoutMargins.bottom = 24
    
    return sv
  }()
  
  private let nextButton: MainButton = {
    let button = MainButton()
    button.setTitle("Next", for: .normal)
    button.isEnabled = false
    return button
  }()
  
  private lazy var afterCountdownStackView: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [
        self.afterCountdownTitle,
        self.queenIconLabel,
        self.nextButton
      ],
      alignment: .center,
      distribution: .equalSpacing
    )
    return sv
  } ()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    backgroundCreator.configureLayout()
    configureLayoutBeforeCountdown()
    configureNavButtonBinding()
    
    if viewModel.settings.canSkipQueen {
      replaceView()
      return
    }
    viewModel.countdown()
    configureCountdownBinding()
  }
}


// MARK: - Layout

extension QueenSelectedViewController {
  
  private func configureLayoutBeforeCountdown() {
    
    beforeCountdownStackView.configureSuperView(under: view)
    beforeCountdownStackView.matchParent(
      padding: .init(
        top: Constant.Common.topSpacing,
        left: Constant.Common.leadingSpacing,
        bottom: Constant.Common.bottomSpacing,
        right: Constant.Common.trailingSpacing
      )
    )
  }
  
  private func replaceView() {
    self.beforeCountdownStackView.removeFromSuperview()
    
    // Set up, but make last half views invisible
    afterCountdownStackView.alpha = 0
    configureLayoutAfterCountdown()
    
    // Fade in the last half views
    UIView.animate(
      withDuration: 1.8,
      delay: 0,
      options: .curveEaseIn,
      animations: {
        self.afterCountdownStackView.alpha = 1
      },
      completion: { _ in
        self.nextButton.isEnabled = true
      }
    )
    
  }
  
  private func configureLayoutAfterCountdown() {
    
    afterCountdownStackView.configureSuperView(under: super.view)
    afterCountdownStackView.matchParent(
      padding: .init(
        top: Constant.Common.topSpacing,
        left: Constant.Common.leadingSpacing,
        bottom: Constant.Common.bottomSpacing,
        right: Constant.Common.trailingSpacing
      )
    )
  }
  
}


// MARK: - Binding

extension QueenSelectedViewController {
  
  private func configureNavButtonBinding() {
    skipButton.rx
      .tap
      .bind { [weak self] _ in
        self?.viewModel.rxCountdownTime.onCompleted()
      }
      .disposed(by: disposeBag)
    
    nextButton.rx
      .tap
      .bind { [weak self] _ in
        guard let self = self else { return }
        let nx = CommandSelectionViewController()
        GameManager.shared.pushGameProgress(
          navVC: self.navigationController,
          currentScreen: self,
          nextScreen: nx
        )
      }
      .disposed(by: disposeBag)
  }
  
  private func configureCountdownBinding() {
    viewModel.rxCountdownTime
      .subscribe(onNext: { [weak self] time in
        guard let time = time else { return }
        DispatchQueue.main.async {
          self?.countdownStackView.countdownLabel.text = String(time)
          self?.viewModel.rotateSuite(time: time, view: self?.countdownStackView)
        }
      },
      onCompleted: {
        self.replaceView()
      })
      .disposed(by: disposeBag)
  }
  
}
