//
//  CommandEditViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

// MARK: - Basics

class CommandEditViewController: UIViewController {
  
  let viewModel: CommandViewModel!
  
  let saveButton: UIButton = {
    let bt = MainButton(title: "Save")
    bt.addTarget(self, action: #selector(saveTapped(_:)), for: .touchUpInside)
    return bt
  }()
  let cancelButton: UIButton = {
    let bt = SubButton(title: "Cancel")
    bt.addTarget(self, action: #selector(cancelTapped(_:)), for: .touchUpInside)
    return bt
  }()
  let deleteButton: UIButton = {
    let bt = UIButton()
    bt.configLayout(width: 48, height: 48, radius: 20)
    let largeConfig = UIImage.SymbolConfiguration(
      pointSize: 22,
      weight: .medium,
      scale: .default
    )
    bt.setImage(
      UIImage(systemName: "trash", withConfiguration: largeConfig)?
        .withRenderingMode(.alwaysTemplate),
      for: .normal
    )
    bt.tintColor = CustomColor.accent
    bt.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    return bt
  }()
  
  let categoryLabel = H3Label(text: "Category")
  let difficultySegment = CustomSegmentedView("Difficulty", [.levelOne, .levelTwo, .levelThree])
  let commandTypeSegment = CustomSegmentedView("Type", [.cToC, .cToA, .cToQ])
  let contentLabel = H3Label(text: "Content")
  lazy var textView: UITextView = {
    let tv = UITextView()
    tv.configLayout( bgColor: CustomColor.concave, radius: 18)
    tv.contentInset = .init(top: 16, left: 16, bottom: 16, right: 16)
    tv.font = CustomFont.p
    tv.textColor = CustomColor.subMain
    tv.tintColor = CustomColor.accent
    return tv
  } ()
  lazy var stackView = VerticalStackView(
    arrangedSubviews: [categoryLabel, difficultySegment, commandTypeSegment, contentLabel],
    spacing: 24,
    alignment: .fill,
    distribution: .fill
  )
  
  init(viewModel: CommandViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    configLayout()
    configBinding()
  }
}

// MARK: - Target Action
extension CommandEditViewController {
  func configBinding() {
    // If #item reach min, disable delete button.
    viewModel.didReachMinItemSubject
      .map(!)
      .bind(to: deleteButton.rx.isEnabled)
      .disposed(by: viewModel.disposeBag)
    
    // If #character in text field is less than 0 or more than 512, disable save botton.
    textView
      .rx
      .text
      .map { text in
        guard let text = text else { return false }
        return text.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
          && text.count <= 128
      }
      .bind(to: saveButton.rx.isValid)
      .disposed(by: viewModel.disposeBag)
  }
}


// MARK: - Target Action

extension CommandEditViewController {
  @objc func saveTapped(_ sender: UIButton) {
    guard let (detail, difficulty, commandType) = validateInput() else { return }
    viewModel.createOrUpdateItem(detail, difficulty, commandType)
    dismiss()
  }
  
  @objc func cancelTapped(_ sender: UIButton) {
    dismiss()
  }
  
  @objc func deleteTapped(_ sender: UIButton) {
    viewModel.deleteSelectedItem()
    dismiss()
  }
  private func dismiss() {
    dismiss(animated: true, completion: nil)
  }
}


// MARK: - Validation

extension CommandEditViewController {
  private func validateInput() -> (String, Difficulty, CommandType)? {
    // MARK: - validation
    guard let difficulty = Difficulty.init(rawValue: difficultySegment.segmentedControl.selectedSegmentIndex),
          let commandType = CommandType.init(rawValue: commandTypeSegment.segmentedControl.selectedSegmentIndex) else { return nil }
    
    guard let detail = textView.text else {
      // please input invalid
      return nil
    }
    
    return (detail, difficulty, commandType)
  }
}


// MARK: - Layout

extension CommandEditViewController {
  
  private func configLayout() {
    view.configBgColor(bgColor: CustomColor.background)
    
    stackView.configSuperView(under: view)
    stackView.anchors(
      topAnchor: view.topAnchor,
      leadingAnchor: view.leadingAnchor,
      trailingAnchor: view.trailingAnchor,
      bottomAnchor: nil,
      padding: .init(top: 108, left: 32, bottom: 0, right: 32)
    )
    stackView.setCustomSpacing(16, after: difficultySegment)
    stackView.setCustomSpacing(32, after: commandTypeSegment)
    
    // Exclude textview from stack view. This is because we can't use .fill for text view. The only way to set size of text view is set static size or set anchor.
    textView.configSuperView(under: view)
    textView.anchors(
      topAnchor: stackView.bottomAnchor,
      leadingAnchor: view.leadingAnchor,
      trailingAnchor: view.trailingAnchor,
      bottomAnchor: view.bottomAnchor,
      padding: .init(top: 24, left: 32, bottom: -Constant.Common.bottomSpacing*2, right: 32)
    )
    
    cancelButton.configSuperView(under: view)
    cancelButton.anchors(
      topAnchor: view.topAnchor,
      leadingAnchor: view.leadingAnchor,
      trailingAnchor: nil,
      bottomAnchor: nil,
      padding: .init(top: 32, left: 32 - 16, bottom: 0, right: 0)
    )
    
    saveButton.configSuperView(under: view)
    saveButton.anchors(
      topAnchor: view.topAnchor,
      leadingAnchor: nil,
      trailingAnchor: view.trailingAnchor,
      bottomAnchor: nil,
      padding: .init(top: 32, left: 0, bottom: 0, right: 32)
    )
    
    // If edit mode, add delete button
    if let _ = viewModel.selectedCommand {
      deleteButton.configSuperView(under: view)
      deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constant.Common.bottomSpacing).isActive = true
      deleteButton.centerXin(view)
    }
    
    if let command = viewModel.selectedCommand {
      difficultySegment.segmentedControl.selectedSegmentIndex = command .difficulty.rawValue
      commandTypeSegment.segmentedControl.selectedSegmentIndex = command .commandType.rawValue
      textView.text = command.detail
    }
    
  }
}
