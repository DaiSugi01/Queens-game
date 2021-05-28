//
//  CitizenSelectedViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit
import RxSwift
import RxCocoa

class CitizenSelectedViewController: UIViewController {

  let disposeBag = DisposeBag()

  let viewModel = CitizenSelectedViewModel()

  lazy var countdownStackView = CountdownStackView(
    countdown: self.viewModel.countdownTime
  )

  let screenTitle: H2Label = {
    let lb = H2Label(text: "Selecting the citizen...")
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.lineBreakMode = .byWordWrapping
    lb.numberOfLines = 0
    lb.setContentHuggingPriority(.required, for: .vertical)
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
    let lb = H2Label(text: "Target is...")
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.lineBreakMode = .byWordWrapping
    lb.numberOfLines = 0
    lb.setContentHuggingPriority(.required, for: .vertical)
    return lb
  }()

  let nextButton: SubButton = {
    let button = SubButton()
    button.setTitle("Next", for: .normal)
    button.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
    return button
  }()

  lazy var targetIcon: UIImageView = {
    let idIcon = IconFactory.createImageView(
      type: .userId(self.viewModel.target.playerId),
      width: 64
    ) as! UserIdIconView
    return idIcon
  }()

  lazy var targetName: PLabel = {
    let label = PLabel(text: self.viewModel.target.name)
    label.textAlignment = .center
    return label
  }()

  lazy var stakeholderIcon = IconFactory.createImageView(
    type: .userId(self.viewModel.stakeholder.playerId),
    width: 64
  )

  lazy var stakeholderName: PLabel = {
    let label = PLabel(text: self.viewModel.stakeholder.name)
    label.textAlignment = .center
    return label
  }()

  lazy var targetBlock: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [self.targetIcon, self.targetName]
    )
    stackView.spacing = 8
    return stackView
  }()

  lazy var stakeholderBlock: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [self.stakeholderIcon, self.stakeholderName]
    )
    stackView.spacing = 8
    return stackView
  }()

  lazy var commandBlock: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [self.targetBlock],
      alignment: .center
    )
    stackView.spacing = 64
    return stackView
  }()

  lazy var afterCountdown: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [
        self.afterTitle,
        self.commandBlock
      ],
      distribution: .equalSpacing
    )
    return stackView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
    if self.viewModel.settings.canSkipOrderSelection {
      self.replaceView()
    }
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
  
}

extension CitizenSelectedViewController {

  private func setupLayout() {
    view.configBgColor(bgColor: CustomColor.background)
    navigationItem.hidesBackButton = true

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

  private func setLayoutAfterCountdown() {
    super.view.addSubview(self.afterCountdown)
    afterCountdown.topAnchor.constraint(
      equalTo: view.topAnchor,
      constant: Constant.Common.topSpacing
    ).isActive = true
    afterCountdown.bottomAnchor.constraint(
      equalTo: view.bottomAnchor,
      constant: Constant.Common.bottomSpacing
    ).isActive = true
    afterCountdown.leadingAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.leadingAnchor,
      constant: Constant.Common.leadingSpacing
    ).isActive = true
    afterCountdown.trailingAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.trailingAnchor,
      constant:  Constant.Common.trailingSpacing
    ).isActive = true

    if self.viewModel.getGameManager().command.commandType == .cToC {
      self.commandBlock.addArrangedSubview(self.stakeholderBlock)
    }
    self.afterCountdown.addArrangedSubview(self.nextButton)
  }

  @objc func skipButtonTapped(_ sender: UIButton) {
    self.viewModel.rxCountdownTime.onCompleted()
  }

  @objc func nextButtonTapped(_ sender: UIButton) {
    self.toResult()
  }

  private func toResult() {
    let nx = ResultViewController(
      target:self.viewModel.target,
      stakeholders:self.viewModel.stakeholders
    )
    GameManager.shared.pushGameProgress(
      navVC: navigationController,
      currentScreen: self,
      nextScreen: nx
    )
  }

  private func replaceView() {
    self.stackView.removeFromSuperview()
    self.setLayoutAfterCountdown()
  }

}

struct MockGameManager: GameManagerProtocol {

  var users: [User] = {
    let user1 = User(id: UUID(), playerId: 1, name: "Paul", isQueen: true)
    let user2 = User(id: UUID(), playerId: 2, name: "Freeman")
    let user3 = User(id: UUID(), playerId: 3, name: "Drake")
    let user4 = User(id: UUID(), playerId: 4, name: "Baldwin")
    let user5 = User(id: UUID(), playerId: 5, name: "Palmer")
    let user6 = User(id: UUID(), playerId: 6, name: "Lee")
    let user7 = User(id: UUID(), playerId: 7, name: "Fletcher")
    return [user1,user2,user3,user4,user5,user6,user7]
  }()

  var queen: User?

  var command = Command(
    detail: """
    Sing a song in front of others and Look each other deeply 30secs
    Sing a song in front of others and Look each other deeply 30secs
    Sing a song in front of others and Look each other deeply 30secs
    """,
    difficulty: .easy,
    commandType: .cToQ
  )

  init() {
    self.queen = self.users[0]
  }


}
