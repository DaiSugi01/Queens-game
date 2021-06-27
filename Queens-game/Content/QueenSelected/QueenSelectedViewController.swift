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
  
  let disposeBag = DisposeBag()
  let viewModel = QueenSelectedViewModel()
  
  
  // MARK: - Before countdown views
  
  lazy var countdownStackView = CountdownStackView(
    countdown: self.viewModel.countdownTime
  )
  
  let beforeCountdownTitle: H2Label = {
    let lb = H2Label(text: "Choosing a Queen...")
    lb.textAlignment = .center
    return lb
  }()
  
  let skipButton: SubButton = {
    let button = SubButton()
    button.setTitle("Skip", for: .normal)
    button.addTarget(self, action: #selector(skipButtonTapped(_:)), for: .touchUpInside)
    button.insertIcon(IconFactory.createSystemIcon("chevron.right.2", weight: .bold), to: .right)
    return button
  }()
  
  
  lazy var beforeCountdownStackView: VerticalStackView = {
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
  
  let afterCountdownTitle: H2Label = {
    let lb = H2Label(text: "The Queen is")
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.lineBreakMode = .byWordWrapping
    return lb
  }()
  
  lazy var queenIcon: UIImageView = {
    let icon = IconFactory.createImageView(
      type: .queen,
      height: 152
    )
    return icon
  }()
  
  lazy var userNumberLabel: H2Label = {
    let label = H2Label(text: "No.")
    label.textColor = CustomColor.accent
    label.textAlignment = .right
    return label
  }()
  
  lazy var targetUserIcon: UIImageView = {
    let icon = IconFactory.createImageView(
      type: .userId(GameManager.shared.queen!.playerId),
      width: 64
    ) as! UserIdIconView
    icon.label.textColor = CustomColor.accent
    return icon
  }()
  
  lazy var targetUserName: H2Label = {
    let label = H2Label(text: GameManager.shared.queen!.name)
    label.textAlignment = .center
    label.textColor = CustomColor.accent
    return label
  }()
  
  lazy var targetIconLabel: HorizontalStackView = {
    let sv = HorizontalStackView(
      arrangedSubviews: [self.userNumberLabel, targetUserIcon]
    )
    sv.distribution = .equalSpacing
    sv.alignment = .center
    sv.spacing = 16
    sv.setContentHuggingPriority(.required, for: .vertical)
    return sv
  }()
  
  lazy var queenIconLabel: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [self.queenIcon, self.targetIconLabel, self.targetUserName]
    )
    sv.alignment = .center
    sv.spacing = 24
    
    return sv
  }()
  
  let nextButton: MainButton = {
    let button = MainButton()
    button.setTitle("Next", for: .normal)
    button.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
    button.isEnabled = false
    return button
  }()
  
  
  lazy var afterCountdownStackView: VerticalStackView = {
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
    if self.viewModel.settings.canSkipQueen {
      self.replaceView()
      return
    }
    self.viewModel.countdown()
    self.viewModel.rxCountdownTime
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

  
  private func configureLayoutBeforeCountdown() {
    
    beforeCountdownStackView.configSuperView(under: view)
    beforeCountdownStackView.matchParent(
      padding: .init(
        top: Constant.Common.topSpacing,
        left: Constant.Common.leadingSpacing,
        bottom: Constant.Common.bottomSpacing,
        right: Constant.Common.trailingSpacing
      )
    )
  }
  
  private func configureLayoutAfterCountdown() {
    
    afterCountdownStackView.configSuperView(under: super.view)
    afterCountdownStackView.matchParent(
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
    self.configureLayoutAfterCountdown()
    
    // Fade in the last half views
    UIView.animate(
      withDuration: 1.8,
      delay: 0,
      options: .curveEaseIn,
      animations: { [weak self] in
        self?.afterCountdownStackView.alpha = 1
      },
      completion: { [weak self] _ in
        self?.nextButton.isEnabled = true
      }
    )
    
  }
  
  @objc func skipButtonTapped(_ sender: UIButton) {
    self.viewModel.rxCountdownTime.onCompleted()
  }
  
  @objc func nextButtonTapped(_ sender: UIButton) {
    self.goToNext()
  }
  
  private func goToNext() {
    let nx = CommandSelectionViewController()
    GameManager.shared.pushGameProgress(
      navVC: navigationController,
      currentScreen: self,
      nextScreen: nx
    )
  }
}
