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

  lazy var executor = self.createExecutor(self.getGameManager())

  lazy var countdownStackView = CountdownStackView(
    countdown: self.viewModel.countdonwTime
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

  override func viewDidLoad() {
    super.viewDidLoad()
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

  @objc func skipButtonTapped(_ sender: UIButton) {
    self.viewModel.rxCountdownTime.onCompleted()
  }

  private func toResult() {
    let (target, stakeholder) = self.executor.select(from: self.getGameManager())
    let nx = ResultViewController(target:target, stakeholder:stakeholder)
    GameManager.shared.pushGameProgress(
      navVC: navigationController,
      currentScreen: self,
      nextScreen: nx
    )
  }

  private func replaceView() {
    self.stackView.removeFromSuperview()
    self.toResult()
  }

  private func createExecutor(_ gameManager: GameManagerProtocol) -> ExecutorProtocol {
    switch gameManager.command.commandType {
    case .cToC:
      return ExecutorCtoC()
    case .cToA:
      return ExecutorCtoA()
    case .cToQ:
      return ExecutorCtoQ()
    }
  }

  private func getGameManager() -> GameManagerProtocol {
    if GameManager.shared.users.count > 0 {
      return GameManager.shared
    } else {
      return MockGameManager()
    }
  }

}

struct MockGameManager: GameManagerProtocol {

  var users: [User] = {
    let user1 = User(id: UUID(), playerId: 1, name: "Dusk", isQueen: true)
    let user2 = User(id: UUID(), playerId: 2, name: "Khumub")
    let user3 = User(id: UUID(), playerId: 3, name: "Puyeim")
    let user4 = User(id: UUID(), playerId: 4, name: "Tuugax")
    let user5 = User(id: UUID(), playerId: 5, name: "Nosh")
    let user6 = User(id: UUID(), playerId: 6, name: "Bengzeing")
    let user7 = User(id: UUID(), playerId: 7, name: "Sogod")
    return [user1,user2,user3,user4,user5,user6,user7]
  }()

  var queen: User?

  var command = Command(
    detail: """
    Sing a song in front of others and Look each other deeply 30secs
    Sing a song in front of others and Look each other deeply 30secs
    Sing a song in front of others and Look each other deeply 30secs
    """,
    difficulty: .hard,
    commandType: .cToA
  )

  init() {
    self.queen = self.users[0]
  }


}
