//
//  ResultViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class ResultViewController: UIViewController, QueensGameViewControllerProtocol {
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorWithMenu(viewController: self)
  
  private let viewModel = ResultViewModel()
  
  private let navButtons = MainButton()
  
  private var target: User
  
  private var stakeholder: User
  
  private var stakeholders: [User]
  
  private lazy var gameManager = viewModel.getGameManager()
  
  private let screenTitle: H2Label = {
    let lb = H2Label(text: "Time to carry out!")
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.lineBreakMode = .byWordWrapping
    lb.setContentHuggingPriority(.required, for: .vertical)
    return lb
  }()
  
  
  // Target views
  
  private let targetTitle = H3Label(text: "Target")
  
  private lazy var targetIconLabel = viewModel.iconLabelCreator(.userId(target.playerId), target.name)
  
  private lazy var stakeholderIconLabel = viewModel.iconLabelCreator(.userId(stakeholder.playerId), self.stakeholder.name)
  
  private lazy var allCitizenIconLabel = viewModel.iconLabelCreator(.allCitizen, "Others")
  
  private lazy var queenIconLabel = viewModel.iconLabelCreator(.queen, "Queen")
  
  private lazy var rightSideIconLabel: UIView = {
    var uiview = UIView()
    switch viewModel.getGameManager().command.commandType {
      case .cToA:
        uiview = allCitizenIconLabel
      case .cToC:
        uiview = stakeholderIconLabel
      case .cToQ:
        uiview = queenIconLabel
    }
    return uiview
  }()
  
  private lazy var arrow = IconFactory.createImageView(type: .arrow, height: 64)
  
  private lazy var targetBlock: UIView = {
    let stackView = HorizontalStackView(
      arrangedSubviews: [
        targetIconLabel,
        arrow,
        rightSideIconLabel,
      ],
      alignment: .top,
      distribution: .equalSpacing
    )
    
    // Wrapper to make side margin
    let wrapper = UIView()
    stackView.configureSuperView(under: wrapper)
    stackView.matchParent(
      padding: .init(top: 0, left: 12, bottom: 0, right: 12)
    )
    return wrapper
  }()
  
  
  // Detail views
  
  private let detailTitle = H3Label(text: "Command")
  
  private lazy var detailText: UILabel = {
    let label = PLabel(text: gameManager.command.detail)
    return label
  }()
  
  private lazy var detailBlock: UIView = {
    let background = UIView()
    let wrapper = UIView() // This is needed for make padding
    detailText.configureSuperView(under: background)
    background.configureSuperView(under: wrapper)
    
    detailText.matchParent(
      padding: .init(top: 16, left: 16, bottom: 16, right: 16)
    )
    background.matchParent(
      padding: .init(top: 0, left: 8, bottom: 0, right: 16)
    )
    background.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
    background.configureLayout(bgColor: CustomColor.backgroundUpper, radius: 16)
    return wrapper
  }()
  
  
  // Attributes views
  
  private lazy var difficultyStackView = CommandAttributeStackView(
    command: GameManager.shared.command,
    attributeType: .difficulty,
    color: CustomColor.subText
  )
  
  private lazy var typeStackView = CommandAttributeStackView(
    command:  GameManager.shared.command,
    attributeType: .targetType,
    color: CustomColor.subText
  )
  
  
  // All views
  private lazy var stackView: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [
        screenTitle,
        targetTitle,
        targetBlock,
        detailTitle,
        detailBlock,
        difficultyStackView,
        typeStackView
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
  
  private lazy var scrollView = DynamicHeightScrollView(
    contentView: stackView,
    padding: .init(
      top: Constant.Common.topSpacingFromTopLine,
      left: Constant.Common.leadingSpacing,
      bottom: Constant.Common.bottomSpacingFromBottomLine*2.4,
      right: Constant.Common.trailingSpacing
    )
  )
  
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
    configureLayout()
    backgroundCreator.configureLayout()
    
    configureNavButtonBinding()
    revealNavButton()
  }
  
}


// MARK: - Layout

extension ResultViewController {
  
  private func configureLayout() {
    scrollView.configureSuperView(under: view)
    scrollView.matchParent(
      padding: .init(
        top: Constant.Common.topLineHeight,
        left: 0,
        bottom: Constant.Common.bottomLineHeight,
        right: 0
      )
    )
    
    configureButtonsLayout()
  }
  
  private func configureButtonsLayout() {
    navButtons.setTitle("Done?", for: .normal)
    navButtons.insertIcon(
      nil,
      to: .right
    )
    navButtons.configureSuperView(under: view)
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
    ) {
      
      self.navButtons.alpha = 1
      self.navButtons.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    } completion: {  _ in
      self.navButtons.isUserInteractionEnabled = true
    }
  }
}


// MARK: - binding

extension ResultViewController {
  private func configureNavButtonBinding() {
    navButtons.rx
      .tap
      .bind { [weak self] _ in
        guard let self =  self else { return }
        
        let nx = ScreenSelectionViewController()
        GameManager.shared.pushGameProgress(
          navVC: self.navigationController,
          currentScreen: self,
          nextScreen: nx
        )
      }
      .disposed(by: viewModel.disposedBag)
  }
}
