//
//  ResultViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class ResultViewController: UIViewController, QueensGameViewControllerProtocol {
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorWithMenu(viewController: self)

  let navButtons = MainButton()

  var target: User

  var stakeholder: User

  var stakeholders: [User]

  lazy var gameManager = self.getGameManager()

  let screenTitle: H2Label = {
    let lb = H2Label(text: "Time to carry out!")
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.lineBreakMode = .byWordWrapping
    lb.setContentHuggingPriority(.required, for: .vertical)
    return lb
  }()
  

  // Target

  let targetTitle = H3Label(text: "Target")

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

  lazy var targetBlock: UIView = {
    let stackView = HorizontalStackView(
      arrangedSubviews: [
        self.targetIconLabel,
        self.arrow,
        self.rightSideIconLabel,
      ],
      alignment: .top,
      distribution: .equalSpacing
    )
    
    // Wrapper to make side margin
    let wrapper = UIView()
    stackView.configSuperView(under: wrapper)
    stackView.matchParent(
      padding: .init(top: 0, left: 4, bottom: 0, right: 8)
    )
    return wrapper
  }()
  
  
  // Detail
  
  let detailTitle = H3Label(text: "Command")

  lazy var detailText: UILabel = {
    let label = PLabel(text: self.gameManager.command.detail)
    return label
  }()
  
  lazy var detailBlock: UIView = {
    let background = UIView()
    let wrapper = UIView() // This is needed for make padding
    detailText.configSuperView(under: background)
    background.configSuperView(under: wrapper)
    
    detailText.matchParent(
      padding: .init(top: 16, left: 16, bottom: 16, right: 16)
    )
    background.matchParent(
      padding: .init(top: 0, left: 0, bottom: 0, right: 8)
    )
    background.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
    background.configLayout(bgColor: CustomColor.backgroundUpper, radius: 16)
    return wrapper
  }()
  

  // Attributes
  
  lazy var difficultyStackView = CommandAttributeStackView(
    command: GameManager.shared.command,
    attributeType: .difficulty,
    color: CustomColor.subText
  )
  
  lazy var typeStackView = CommandAttributeStackView(
    command:  GameManager.shared.command,
    attributeType: .targetType,
    color: CustomColor.subText
  )
  

  // All
  lazy var stackView: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [
        self.screenTitle,
        self.targetTitle,
        self.targetBlock,
        self.detailTitle,
        self.detailBlock,
        self.difficultyStackView,
        self.typeStackView
      ],
      spacing: 24
    )
    stackView.setCustomSpacing(Constant.Common.topSpacingFromTitle, after: screenTitle)
    stackView.setCustomSpacing(12, after: targetTitle)
    stackView.setCustomSpacing(12, after: detailTitle)
    stackView.setCustomSpacing(32, after: targetBlock)
    stackView.setCustomSpacing(60, after: detailBlock)
    return stackView
  }()

  lazy var scrollView = DynamicHeightScrollView(
    contentView: stackView,
    padding: .init(
      top: Constant.Common.topSpacingFromTopLine,
      left: Constant.Common.leadingSpacing,
      bottom: Constant.Common.bottomSpacingFromBottomLine,
      right: Constant.Common.trailingSpacing
    )
  )
  
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
    self.setupLayout()
    self.configureButtons()
    backgroundCreator.configureLayout()
    
    revealNavButton()
  }
  
}

extension ResultViewController {

  private func setupLayout() {
    scrollView.configSuperView(under: view)
    scrollView.matchParent(
      padding: .init(
        top: Constant.Common.topLineHeight,
        left: 0,
        bottom: Constant.Common.bottomLineHeight,
        right: 0
      )
    )

  }

  private func configureButtons() {
    navButtons.setTitle("Done?", for: .normal)
    navButtons.insertIcon(
      nil,
      to: .right
    )
    navButtons.addTarget(
      self,
      action: #selector(nextTapped),
      for: .touchUpInside
    )
    navButtons.configSuperView(under: view)
    navButtons.centerXin(view)
    navButtons.bottomAnchor.constraint(
      equalTo: view.bottomAnchor,
      constant: -Constant.Common.bottomSpacing
    ).isActive = true
    navButtons.isUserInteractionEnabled = false
    navButtons.alpha = 0
    navButtons.transform = CGAffineTransform(scaleX: -4.8, y: 4.8)

  }
  
  // Revealing + bouncing button
  private func revealNavButton() {
    UIView.animate(
      withDuration: 1,
      delay: 2,
      usingSpringWithDamping: 0.56,
      initialSpringVelocity: 0,
      options: .curveEaseInOut
    ) { [weak self] in
      self?.navButtons.alpha = 1
      self?.navButtons.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    } completion: { [weak self] _ in
      self?.navButtons.isUserInteractionEnabled = true
    }
  }
  
  @objc private func nextTapped() {
    let nx = ScreenSelectionViewController()
    GameManager.shared.pushGameProgress(navVC: navigationController,
                                        currentScreen: self,
                                        nextScreen: nx)
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
