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
  
  var viewModel = CommandViewModel()
  var selectedCommand: Command!
  
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
  let sectionLabel: H2Label = {
    let lb = H2Label(text: "Ready to give this order?")
    return lb
  } ()
  
  
  // MARK: - Command description

  let subSectionDescriptionLabel: H3Label = {
    let lb = H3Label(text: "Command")
    return lb
  } ()
  
  lazy var detail: UIStackView = {
    let wrapper = UIStackView()
    wrapper.configLayout(bgColor: CustomColor.convex, radius: 32)
    let content: UILabel = H4Label(text: selectedCommand.detail)
    wrapper.addArrangedSubview(content)
    wrapper.isLayoutMarginsRelativeArrangement = true
    wrapper.directionalLayoutMargins = .init(top: 32, leading: 16, bottom: 32, trailing: 16)
    return wrapper
  } ()
  
  let confirmationButton: UIView = {
    let bt = NextAndBackButtons()
    bt.backButton.setTitle("Cancel", for: .normal)
    bt.backButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
    bt.nextButton.setTitle("Yes", for: .normal)
    bt.nextButton.addTarget(self, action: #selector(yesTapped), for: .touchUpInside)
    bt.nextButton.configBgColor(bgColor: CustomColor.accent)
    // Create a wrapper to float (don't let stretch) buttons.
    let uv = UIView()
    bt.configSuperView(under: uv)
    // Don't let stretch buttons.
    bt.setContentHuggingPriority(.required, for: .horizontal)
    // Only set wrapper's height same as buttons.
    bt.heightAnchor.constraint(equalTo: uv.heightAnchor).isActive = true
    // let buttons float in center
    bt.centerXYin(uv)
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
    color: CustomColor.subMain
  )
  
  lazy var typeStackView = CommandAttributeStackView(
    command: selectedCommand,
    attributeType: .targetType,
    color: CustomColor.subMain
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
        sectionLabel,
        subSectionDescriptionLabel,
        detail,
        confirmationButton,
        attributesStackView
      ]
    )
    sv.setCustomSpacing(40, after: sectionLabel)
    sv.setCustomSpacing(16, after: subSectionDescriptionLabel)
    sv.setCustomSpacing(40, after: detail)
    sv.setCustomSpacing(56, after: confirmationButton)
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
}
