//
//  CommandConfirmationViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

// MARK: - Instance variables
class CommandConfirmationViewController: UIViewController {
  
  var viewModel = CommandViewModel()
  var selectedCommand: Command!
  
  let scrollView = UIScrollView()
  
  // Details
  let mainLabel: H2Label = {
    let lb = H2Label(text: "Confirm this command?")
    return lb
  } ()
  
  let detailLabel: H3Label = {
    let lb = H3Label(text: "Description")
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
  
  // Attributes
  let difficultyLabel : H4Label = {
    let lb = H4Label(text: "Difficulty")
    lb.textColor = CustomColor.subMain
    return lb
  } ()
  
  lazy var difficultyIcon: UIImageView = {
    let iconType = selectedCommand.difficultyIconType
    let icon = IconFactory.createImageView(type: iconType, width: 40)
    return icon
  } ()

  lazy var difficultyDescription : PLabel = {
    let lb = PLabel(text: selectedCommand.difficultyDescription)
    lb.textColor = CustomColor.subMain
    return lb
  } ()
  
  let typeLabel : H4Label = {
    let lb = H4Label(text: "Type")
    lb.textColor = CustomColor.subMain
    return lb
  } ()
  
  lazy var typeIcon: UIImageView = {
    let iconType = selectedCommand.commandIconType
    let icon = IconFactory.createImageView(type: iconType, width: 40)
    return icon
  } ()
  
  lazy var typeDescription : PLabel = {
    let lb = PLabel(text: selectedCommand.commandTypeDescription)
    lb.textColor = CustomColor.subMain
    return lb
  } ()
  
  lazy var attributesStackView: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [
        difficultyLabel,
        difficultyIcon,
        difficultyDescription,
        typeLabel,
        typeIcon,
        typeDescription
      ],
      alignment: .leading
    )
    sv.setCustomSpacing(4, after: difficultyLabel)
    sv.setCustomSpacing(8, after: difficultyIcon)
    sv.setCustomSpacing(32, after: difficultyDescription)
    sv.setCustomSpacing(4, after: typeLabel)
    sv.setCustomSpacing(8, after: typeIcon)
    return sv
  } ()

  // All in one
  lazy var stackView: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [
        mainLabel,
        detailLabel,
        detail,
        confirmationButton,
        attributesStackView
      ]
    )
    sv.setCustomSpacing(40, after: mainLabel)
    sv.setCustomSpacing(16, after: detailLabel)
    sv.setCustomSpacing(40, after: detail)
    sv.setCustomSpacing(40, after: confirmationButton)
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
    configScrollView()
  }

}


// MARK: - Scroll view

extension CommandConfirmationViewController {
  private func configScrollView() {
    scrollView.configSuperView(under: view)
    scrollView.matchParent()
    scrollView.configBgColor(bgColor: CustomColor.background)

    // This will create padding between content size and stack view
    scrollView.contentInset = .init(
      top: Constant.Common.topSpacing/2,
      left: Constant.Common.leadingSpacing,
      bottom: 64,
      right: Constant.Common.trailingSpacing
    )
    
    // Only set stack-view's width
    stackView.configSuperView(under: scrollView)
    stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -2*Constant.Common.leadingSpacing).isActive = true
    // By this, stack view won't scroll horizontally
    stackView.centerXin(view)
    
    // This will create subviews earlier.
    // Without this, it will cost few times to decide scroll height.
    scrollView.layoutIfNeeded()
  }
  
  // This will called when the subviews are created.
  // After created, based on the stack view's height, we set content size.
  override func viewDidLayoutSubviews() {
    scrollView.contentSize = CGSize(width: view.frame.width, height: stackView.frame.height)
  }
}


// MARK: - Transition

extension CommandConfirmationViewController {
  @objc func cancelTapped() {
    dismiss(animated: true, completion: nil)
  }
  
  @objc func yesTapped() {
    GameManager.shared.command = selectedCommand
    
    self.viewModel.confirmedTriggerSubject.onNext(())
    dismiss(animated: true, completion:nil)
  }
}
