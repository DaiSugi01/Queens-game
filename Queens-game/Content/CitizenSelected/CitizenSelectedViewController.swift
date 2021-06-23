//
//  CitizenSelectedViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit
import RxSwift
import RxCocoa

class CitizenSelectedViewController:  UIViewController, QueensGameViewControllerProtocol {
  
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorPlain(parentView: view)
  

  let disposeBag = DisposeBag()

  let viewModel = CitizenSelectedViewModel()

  // MARK: - Before count down stack view
  
  lazy var countdownStackView = CountdownStackView(
    countdown: self.viewModel.countdownTime
  )

  let beforeCountdownTitle: H2Label = {
    let lb = H2Label(text: "Choosing citizens...")
    lb.lineBreakMode = .byWordWrapping
    lb.setContentHuggingPriority(.required, for: .vertical)
    lb.textAlignment = .center
    return lb
  }()

  let skipButton: SubButton = {
    let button = SubButton()
    button.setTitle("Skip", for: .normal)
    button.addTarget(self, action: #selector(skipButtonTapped(_:)), for: .touchUpInside)
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
    sv.alignment = .fill
    sv.distribution = .equalSpacing
    return sv
  }()

  // MARK: After Countdown views

  let afterCountdownTitle: H2Label = {
    let lb = H2Label(text: "You are chosen...")
    lb.lineBreakMode = .byWordWrapping
    lb.setContentHuggingPriority(.required, for: .vertical)
    return lb
  }()

  lazy var targetUserIcon: UIImageView = createLargeUserIcon(id: viewModel.target.playerId)

  lazy var targetUserName: H3Label = {
    let label = H3Label(text: self.viewModel.target.name)
    label.textAlignment = .center
    return label
  }()
  
  lazy var targetWrapper: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [self.targetUserIcon, self.targetUserName]
    )
    stackView.spacing = 8
    return stackView
  }()


  // We might insert stakeHolder views into here, if c to c
  lazy var commandWrapper: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [self.targetWrapper],
      alignment: .center
    )
    stackView.spacing = 40
    return stackView
  }()
  
  let nextButton: MainButton = {
    let button = MainButton()
    button.setTitle("Next", for: .normal)
    button.addTarget(
      self,
      action: #selector(nextButtonTapped(_:)),
      for: .touchUpInside
    )
    button.isEnabled = false
    return button
  }()

  lazy var afterCountdownStackView: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [
        self.afterCountdownTitle,
        self.commandWrapper,
        self.nextButton
      ],
      alignment: .center,
      distribution: .equalSpacing
    )
    return stackView
  }()
  
  
  // MARK: - Stakeholder views (this is used for c to c)
  

  lazy var stakeholderIcon: UIImageView = createLargeUserIcon(id: viewModel.stakeholder.playerId)

  lazy var stakeholderName: H3Label = {
    let label = H3Label(text: self.viewModel.stakeholder.name)
    label.textAlignment = .center
    return label
  }()

  lazy var stakeholderStackView: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [self.stakeholderIcon, self.stakeholderName]
    )
    stackView.spacing = 8
    return stackView
  }()
  

  override func viewDidLoad() {
    super.viewDidLoad()
    backgroundCreator.configureLayout()
    configureLayoutBeforeCountdown()
    if self.viewModel.settings.canSkipCommand {
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

  private func configureLayoutBeforeCountdown() {
    
    beforeCountdownStackView.configSuperView(under: super.view)
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

    if self.viewModel.getGameManager().command.commandType == .cToC {
      self.commandWrapper.addArrangedSubview(self.stakeholderStackView)
    }

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
  
  private func createLargeUserIcon(id: Int) -> UIImageView {
    let isTwoIcon = viewModel.getGameManager().command.commandType == .cToC
    
    let idIcon = IconFactory.createImageView(
      type: .userId(id),
      width: isTwoIcon ? 112 : 152
    ) as! UserIdIconView
    idIcon.label.font = CustomFont.h2.withSize(isTwoIcon ? 48 : 64)
    idIcon.configRadius(radius: (isTwoIcon ? 112 : 152)/4)
    return idIcon
  }

}


// MARK: - Mock data

struct MockGameManager: GameManagerProtocol {

  var users: [User] = {
    let user1 = User(id: UUID(), playerId: 1, name: "Paul")
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
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    """,
    difficulty: .easy,
    commandType: .cToC
  )

  init() {
    self.queen = self.users[0]
  }


}
