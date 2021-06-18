//
//  ResultViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class ResultViewController: UIViewController, QueensGameViewControllerProtocol {
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorWithMenu(viewController: self)

  let navButtons = NextAndBackButtons()

  var target: User

  var stakeholder: User

  var stakeholders: [User]

  lazy var gameManager = self.getGameManager()

  let screenTitle: H2Label = {
    let lb = H2Label(text: "It’s time to carry out")
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.lineBreakMode = .byWordWrapping
    lb.numberOfLines = 0
    lb.setContentHuggingPriority(.required, for: .vertical)
    return lb
  }()

  lazy var difficulty: UIImageView = {
    let img = IconFactory.createImageView(type: self.getIconType(), height: 32)
    img.contentMode = .scaleAspectFit
    img.clipsToBounds = true
    return img
  }()

  lazy var targetIconLabel = iconLabelCreator(.userId(self.target.playerId), self.target.name)
  
  lazy var stakeholderIconLabel = iconLabelCreator(.userId(self.stakeholder.playerId), self.stakeholder.name)

  lazy var allCitizenIconLabel = iconLabelCreator(.allCitizen, "Others")

  lazy var queenIconLabel = iconLabelCreator(.queen, "Queen")

  lazy var rightSideIconLabel: UIView = {
    var uiview = UIView()
    switch self.getGameManager().command.commandType {
    case .cToA:
      uiview = self.allCitizenIconLabel
    case .cToC:
      uiview = self.stakeholderIconLabel
    case .cToQ:
      uiview = self.queenIconLabel
    }
    return uiview
  }()

  lazy var arrow = IconFactory.createImageView(type: .arrow, height: 64)

  lazy var commandBlock: HorizontalStackView = {
    let stackView = HorizontalStackView(
      arrangedSubviews: [
        self.targetIconLabel,
        self.arrow,
        self.rightSideIconLabel,
      ],
      alignment: .top,
      distribution: .equalSpacing
    )
    return stackView
  }()

  lazy var detail: UILabel = {
    let label = PLabel(text: self.gameManager.command.detail)
    label.configLayout(width:200)
    return label
  }()

  lazy var detailBlock: UIStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [detail],
      alignment: .leading
    )
    return stackView
  }()

  lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.addSubview(self.detailBlock)
    scrollView.configLayout(height: 130, radius: 16, shadow: true)
    scrollView.configBgColor(bgColor: CustomColor.convex)
    scrollView.directionalLayoutMargins = .init(
      top: 16, leading: 16, bottom: 16, trailing: 16)
    scrollView.isScrollEnabled = true
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()

  lazy var inner: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [
        self.difficulty,
        self.commandBlock,
        self.scrollView
      ],
      spacing: 32
    )
    return stackView
  }()

  lazy var wrapper: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [inner]
    )
    stackView.alignment = .center
    return stackView
  }()

  lazy var stackView: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [
        screenTitle,
        wrapper,
        navButtons,
      ]
    )
    sv.alignment = .fill
    sv.distribution = .equalSpacing
    return sv
  }()

  // MARK: init

  init(target: User, stakeholders: [User]) {
    self.target = target
    self.stakeholders = stakeholders
    self.stakeholder = self.stakeholders[0]
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    backgroundCreator.configureLayout()
    self.setupLayout()
    self.configureButtons()
  }
}

extension ResultViewController {

  private func setupLayout() {

    view.addSubview(stackView)
    stackView.topAnchor.constraint(
      equalTo: view.topAnchor,
      constant: Constant.Common.topSpacing
    ).isActive = true
    stackView.bottomAnchor.constraint(
      equalTo: view.bottomAnchor,
      constant: -Constant.Common.bottomSpacing
    ).isActive = true
    stackView.leadingAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.leadingAnchor,
      constant: Constant.Common.leadingSpacing
    ).isActive = true
    stackView.trailingAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.trailingAnchor,
      constant:  -Constant.Common.trailingSpacing
    ).isActive = true
    inner.widthAnchor.constraint(
      equalTo: stackView.widthAnchor,
      multiplier: 0.8
    ).isActive = true
    detailBlock.topAnchor.constraint(
      equalTo: scrollView.topAnchor,
      constant: 16
    ).isActive = true
    detailBlock.leadingAnchor.constraint(
      equalTo: scrollView.leadingAnchor,
      constant: 16
    ).isActive = true
    detailBlock.trailingAnchor.constraint(
      equalTo: scrollView.trailingAnchor,
      constant: -16
    ).isActive = true
    detailBlock.bottomAnchor.constraint(
      equalTo: scrollView.bottomAnchor
    ).isActive = true

  }

  private func configureButtons() {
    navButtons.nextButton.setTitle("Go to Top", for: .normal)
    navButtons.nextButton.titleLabel?.font = CustomFont.h4
    navButtons.nextButton.addTarget(
      self,
      action: #selector(toTop),
      for: .touchUpInside
    )
    
    navButtons.backButton.setTitle("Select Queen", for: .normal)
    navButtons.backButton.titleLabel?.font = CustomFont.h4
    navButtons.backButton.titleLabel?.lineBreakMode = .byWordWrapping
    navButtons.backButton.addTarget(
      self,
      action: #selector(reselectQueen),
      for: .touchUpInside
    )

  }

  @objc private func reselectQueen() {
    self.resetGameManager()
    let nx = QueenSelectionViewController()
    GameManager.shared.pushGameProgress(
      navVC: navigationController,
      currentScreen: self,
      nextScreen: nx
    )
  }

  @objc private func toTop() {
    self.resetGameManager()
    super.navigationController?.popToRootViewController(animated: true)
  }

  private func getGameManager() -> GameManagerProtocol {
    if GameManager.shared.users.count > 0 {
      return GameManager.shared
    } else {
      return MockGameManager()
    }
  }

  private func getIconType() -> IconType {
    switch self.getGameManager().command.difficulty {
    case .easy:
      return .levelOne
    case .normal:
      return .levelTwo
    case .hard:
      return .levelThree
    }
  }

  private func resetGameManager() {
    for (i, _) in GameManager.shared.users.enumerated() {
      GameManager.shared.users[i].isQueen = false
    }
    GameManager.shared.queen = nil
  }
  
  private func iconLabelCreator(_ iconType: IconType, _ label: String) -> UIStackView {
    let icon = IconFactory.createImageView(type: iconType, height: 64)
    let lb = PLabel(text: label)
    lb.textAlignment = .center
    let sv = VerticalStackView(
      arrangedSubviews: [icon, lb],
      spacing: 8
    )
    return sv
  }
}
