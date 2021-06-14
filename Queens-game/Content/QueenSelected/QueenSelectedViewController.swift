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

  lazy var countdownStackView = CountdownStackView(
    countdown: self.viewModel.countdownTime
  )

  let screenTitle: H2Label = {
    let lb = H2Label(text: "Selecting the Queen...")
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.lineBreakMode = .byWordWrapping
    return lb
  }()

  let skipButton: SubButton = {
    let button = SubButton()
    button.setTitle("Skip", for: .normal)
    button.addTarget(self, action: #selector(skipButtonTapped(_:)), for: .touchUpInside)
    return button
  }()

  lazy var stackView: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [
        screenTitle,
        countdownStackView,
        skipButton
      ]
    )
    sv.alignment = .fill
    sv.distribution = .equalSpacing
    return sv
  }()

  // MARK: After Countdown

  let afterTitle: H2Label = {
    let lb = H2Label(text: "The Queen is")
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.lineBreakMode = .byWordWrapping
    return lb
  }()
    
  lazy var queenIcon: UIImageView = {
    let icon = IconFactory.createImageView(
      type: .queen,
      height: 150
    )
    return icon
  }()
  
  lazy var noLabel: H2Label = {
    let label = H2Label(text: "No.")
    label.textColor = CustomColor.accent
    label.textAlignment = .right
    return label
  }()
  
  lazy var targetIcon: UIImageView = {
    let icon = IconFactory.createImageView(
      type: .userId(GameManager.shared.queen!.playerId),
      width: 64
    ) as! UserIdIconView
    icon.label.textColor = CustomColor.accent
    return icon
  }()

  lazy var queenName: H2Label = {
    let label = H2Label(text: GameManager.shared.queen!.name)
    label.textAlignment = .center
    label.textColor = CustomColor.accent
    return label
  }()
  
  lazy var hStackView: HorizontalStackView = {
    let sv = HorizontalStackView(
      arrangedSubviews: [self.noLabel, targetIcon]
    )
    sv.distribution = .equalSpacing
    sv.alignment = .bottom
    sv.spacing = 16
    return sv
  }()
    
  lazy var queenBlock: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [self.queenIcon, self.hStackView, self.queenName]
    )
    sv.alignment = .center
    sv.distribution = .fill
    sv.spacing = 32
    sv.setCustomSpacing(24, after: hStackView)
    return sv
  }()
  
  let nextButton: MainButton = {
    let button = MainButton()
    button.setTitle("Next", for: .normal)
    button.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    backgroundCreator.configureLayout()
    setupLayout()
    self.viewModel.countdown()
    self.viewModel.rxCountdownTime
      .subscribe(onNext: { [weak self] time in
        self?.countdownStackView.countdownLabel.text = String(time!)
      },
      onCompleted: {
        self.replaceView()
      })
      .disposed(by: disposeBag)
  }

  private func setupLayout() {

    view.addSubview(stackView)
    stackView.topAnchor.constraint(
      equalTo: view.topAnchor,
      constant: Constant.Common.topSpacing
    ).isActive = true
    stackView.bottomAnchor.constraint(
      equalTo: view.bottomAnchor,
      constant: Constant.Common.bottomSpacing
    ).isActive = true
    stackView.leadingAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.leadingAnchor,
      constant: Constant.Common.leadingSpacing
    ).isActive = true
    stackView.trailingAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.trailingAnchor,
      constant:  Constant.Common.trailingSpacing
    ).isActive = true
  }

  private func setupLayoutAfterCountdown() {
    super.view.addSubview(self.afterTitle)
    super.view.addSubview(self.queenBlock)
    super.view.addSubview(self.nextButton)

    afterTitle.topAnchor.constraint(
      equalTo: view.topAnchor,
      constant: Constant.Common.topSpacing
    ).isActive = true
    afterTitle.leadingAnchor.constraint(
      equalTo: view.leadingAnchor,
      constant: Constant.Common.leadingSpacing
    ).isActive = true
    afterTitle.trailingAnchor.constraint(
      equalTo: view.trailingAnchor,
      constant: Constant.Common.trailingSpacing
    ).isActive = true
    
    queenBlock.centerYin(view)
    queenBlock.centerXin(view)

    nextButton.centerXin(view)
    nextButton.bottomAnchor.constraint(
      equalTo: view.bottomAnchor,
      constant: Constant.Common.bottomSpacing
    ).isActive = true
  }
  
  private func replaceView() {
    self.stackView.removeFromSuperview()
    self.setupLayoutAfterCountdown()
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
