//
//  ResultViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class ResultViewController: UIViewController {

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

  lazy var targetIcon = IconFactory.createImageView(type: .userId(self.target.playerId), width: 64)

  lazy var targetName: PLabel = {
    let label = PLabel(text: self.target.name)
    label.textAlignment = .center
    return label
  }()

  lazy var stakeholderIcon = IconFactory.createImageView(type: .userId(self.stakeholder.playerId), width: 64)

  lazy var stakeholderName: PLabel = {
    let label = PLabel(text: self.stakeholder.name)
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

  lazy var allCitizen = IconFactory.createImageView(type: .allCitizen, height: 64)

  lazy var queen = IconFactory.createImageView(type: .queen, height: 64)

  lazy var rightBlock: UIView = {
    var uiview = UIView()
    switch self.getGameManager().command.commandType {
    case .cToA:
      uiview = self.allCitizen
    case .cToC:
      uiview = self.stakeholderBlock
    case .cToQ:
      uiview = self.queen
    }
    return uiview
  }()

  lazy var arrow = IconFactory.createImageView(type: .arrow, height: 64)

  lazy var commandBlock: HorizontalStackView = {
    let stackView = HorizontalStackView(
      arrangedSubviews: [
        self.targetBlock,
        self.arrow,
        self.rightBlock,
      ],
      alignment: .top,
      distribution: .equalSpacing
    )
    return stackView
  }()

  lazy var detail: UILabel = {
    let label = PLabel(text: self.gameManager.command.detail)
    label.numberOfLines = 5
    return label
  }()

  lazy var detailBlock: UIStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [detail],
      alignment: .leading
    )
    stackView.configLayout(height: 130, radius: 16, shadow: true)
    stackView.configBgColor(bgColor: CustomColor.convex)
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.directionalLayoutMargins = .init(
      top: 16, leading: 16, bottom: 16, trailing: 16)
    return stackView
  }()

  lazy var inner: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [
        self.difficulty,
        self.commandBlock,
        self.detailBlock
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
    self.setupLayout()
    self.configureButtons()
  }
}

extension ResultViewController {

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
    inner.widthAnchor.constraint(
      equalTo: stackView.widthAnchor,
      multiplier: 0.8
    ).isActive = true

  }

  private func configureButtons() {
    navButtons.nextButton.setTitle("Play again", for: .normal)
    navButtons.nextButton.titleLabel?.font = CustomFont.h4
    navButtons.nextButton.addTarget(
      self,
      action: #selector(toStart),
      for: .touchUpInside
    )
    
    navButtons.backButton.setTitle("Back to start menu", for: .normal)
    navButtons.backButton.titleLabel?.font = CustomFont.h4
    navButtons.backButton.titleLabel?.lineBreakMode = .byWordWrapping
    navButtons.backButton.addTarget(
      self,
      action: #selector(toTop),
      for: .touchUpInside
    )

  }

  @objc private func toStart() {
    let nx = PlayerSelectionViewController()
    GameManager.shared.pushGameProgress(
      navVC: navigationController!,
      currentScreen: self,
      nextScreen: nx
    )
  }

  @objc private func toTop() {
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
  
}
