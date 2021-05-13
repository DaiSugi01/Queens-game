//
//  CommandEditViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class CommandEditViewController: UIViewController {
  
  let viewModel: CommandSettingViewModel!
  var itemIndex: Int? = nil
  
  let saveButton: UIButton = {
    let bt = MainButton(superView: nil, title: "Save")
    bt.addTarget(self, action: #selector(saveTapped(_:)), for: .touchUpInside)
    return bt
  }()
  let cancelButton: UIButton = {
    let bt = SubButton(superView: nil, title: "Cancel")
    bt.addTarget(self, action: #selector(cancelTapped(_:)), for: .touchUpInside)
    return bt
  }()
  
  let categoryLabel = H3Label(text: "Category")
  let difficultySegment = CustomSegmentedView("Difficulity", [.levelOne, .levelTwo, .levelThree])
  let commandTypeSegment = CustomSegmentedView("Type", [.cToC, .cToA, .cToQ])
  let contentLabel = H3Label(text: "Content")
  let textView: UITextView = {
    let tv = UITextView()
    tv.configSize(height: 128)
    return tv
  } ()
  lazy var stackView = VerticalStackView(
    arrangedSubviews: [categoryLabel, difficultySegment, commandTypeSegment, contentLabel, textView],
    spacing: 24,
    alignment: .fill,
    distribution: .fill
  )
  
  init(viewModel: CommandSettingViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configLayout()
  }
  
  @objc func saveTapped(_ sender: UIButton) {
    // MARK: - FIXME: validation
    guard let difficulty = Difficulty.init(rawValue: difficultySegment.segmentedControl.selectedSegmentIndex),
          let commandType = CommandType.init(rawValue: commandTypeSegment.segmentedControl.selectedSegmentIndex) else { return }
    
    guard let detail = textView.text else {
      // please input invalid
      return
    }
    
    guard detail.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 else {
      // too short
      return
    }
    
    guard detail.trimmingCharacters(in: .whitespacesAndNewlines).count <= 1024 else {
      // too long
      return
    }
    
    // edit
    if let itemIndex = itemIndex {
      let editingCommand = viewModel.commandList[itemIndex]
      editingCommand.detail = detail
      editingCommand.difficulty = difficulty
      editingCommand.commandType = commandType
      viewModel.updateItem(command: editingCommand)
    // add
    } else {
      let addingCommand = Command(detail: detail, difficulty: difficulty, commandType: commandType)
      viewModel.createItem(command: addingCommand)
    }

    dismiss(animated: true, completion: nil)
  }
  
  @objc func cancelTapped(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
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
  }
}
