//
//  CommandConfirmationViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

// MARK: - Instance variables
class CommandConfirmationViewController:  UIViewController, QueensGameViewControllerProtocol {
  
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorWithClose(viewController: self)
  
  private var viewModel: CommandViewModel!
  private var selectedCommand: Command!
  
  lazy var scrollView = DynamicHeightScrollView(
    contentView: stackView,
    padding: .init(
      top: Constant.Common.topSpacingFromTopLine,
      left: Constant.Common.leadingSpacing,
      bottom: Constant.Common.bottomSpacingFromBottomLine,
      right: Constant.Common.trailingSpacing
    )
  )
  
  // Details
  let titleLabel: H2Label = {
    let lb = H2Label(text: "Ready to give this order?")
    return lb
  } ()
  
  
  // MARK: - Command description

  let descriptionTitleLabel: H3Label = {
    let lb = H3Label(text: "Command")
    return lb
  } ()
  
  lazy var descriptionView: UIStackView = {
    let wrapper = UIStackView()
    wrapper.configLayout(bgColor: CustomColor.backgroundUpper, radius: 32)
    let content: UILabel = H4Label(text: selectedCommand.detail)
    wrapper.addArrangedSubview(content)
    wrapper.isLayoutMarginsRelativeArrangement = true
    wrapper.directionalLayoutMargins = .init(top: 32, leading: 16, bottom: 32, trailing: 16)
    return wrapper
  } ()
  
  let confirmationButtons: UIView = {
    let bt = NextAndBackButtons()
    bt.backButton.setTitle("No", for: .normal)
    bt.backButton.insertIcon(IconFactory.createSystemIcon("multiply"), to: .left)
    bt.backButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
    
    bt.nextButton.setTitle("Yes", for: .normal)
    let btTintColor = CustomColor.background.resolvedColor(with: .init(userInterfaceStyle: .light))
    bt.nextButton.setTitleColor(btTintColor, for: .normal)
    bt.nextButton.insertIcon(
      IconFactory.createSystemIcon("checkmark", color: btTintColor),
      to: .right
    )
    bt.nextButton.addTarget(self, action: #selector(yesTapped), for: .touchUpInside)
    bt.nextButton.configBgColor(bgColor: CustomColor.accent)
    
    // Create a wrapper to set a local margin buttons.
    let uv = UIView()
    bt.configSuperView(under: uv)
    NSLayoutConstraint.activate([
      bt.leadingAnchor.constraint(equalTo: uv.leadingAnchor, constant: 0),
      bt.trailingAnchor.constraint(equalTo: uv.trailingAnchor, constant: -8),
      uv.heightAnchor.constraint(equalTo: bt.heightAnchor),
      bt.centerYAnchor.constraint(equalTo: uv.centerYAnchor)
    ])
    return uv
  }()
  
  
  
  // MARK: - Attributes
  
  let subSectionAttributeLabel: H3Label = {
    let lb = H3Label(text: "This command is")
    return lb
  } ()

  lazy var difficultyStackView = CommandAttributeStackView(
    command: selectedCommand,
    attributeType: .difficulty,
    color: CustomColor.subText
  )
  
  lazy var typeStackView = CommandAttributeStackView(
    command: selectedCommand,
    attributeType: .targetType,
    color: CustomColor.subText
  )
  
  
  lazy var attributesStackView: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [
        subSectionAttributeLabel,
        difficultyStackView,
        typeStackView
      ],
      alignment: .leading
    )
    sv.setCustomSpacing(16, after: subSectionAttributeLabel)
    sv.setCustomSpacing(32, after: difficultyStackView)
    return sv
  } ()
  
  
  // MARK: - All in one
  
  lazy var stackView: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [
        titleLabel,
        descriptionTitleLabel,
        descriptionView,
        confirmationButtons,
        attributesStackView
      ]
    )
    sv.setCustomSpacing(Constant.Common.topSpacingFromTitle, after: titleLabel)
    sv.setCustomSpacing(16, after: descriptionTitleLabel)
    sv.setCustomSpacing(40, after: descriptionView)
    sv.setCustomSpacing(48, after: confirmationButtons)
    return sv
  } ()
  
  init(viewModel: CommandViewModel) {
    self.viewModel = viewModel
    self.selectedCommand = viewModel.selectedCommand
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureScrollView()
    backgroundCreator.configureLayout()
  }
  
}


// MARK: - Scroll view

extension CommandConfirmationViewController {
  private func configureScrollView() {
    scrollView.configSuperView(under: view)
    
    // Scroll View
    scrollView.matchParent(
      padding: .init(
        top: Constant.Common.topLineHeight,
        left: 0,
        bottom: Constant.Common.bottomLineHeight,
        right: 0
      )
    )
  }

}


// MARK: - Transition

extension CommandConfirmationViewController {
  @objc func cancelTapped() {
    dismiss(animated: true, completion: nil)
  }
  
  @objc func yesTapped() {
    GameManager.shared.command = selectedCommand
    
    self.viewModel.confirmedTriggerSubject.onCompleted()
    dismiss(animated: true, completion:nil)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    self.viewModel.dismissSubject.onCompleted()
  }
}
