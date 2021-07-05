//
//  CommandEditViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit
import RxCocoa
import RxSwift

// MARK: - Basics

class CommandEditViewController: UIViewController, QueensGameViewControllerProtocol {
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorWithClose(viewController: self)
  
  let viewModel: CommandViewModel!
  
  
  // MARK: - Save and delete button
  
  let saveButton: QueensGameButton = {
    let bt = QueensGameButton()
    // Set image
    let image = IconFactory.createSystemIcon(
      "tray.and.arrow.down.fill",
      pointSize: 22,
      weight: .bold
    )
    bt.setBackgroundImage(image, for: .normal)
    return bt
  }()

  let deleteButton: UIButton = {
    let bt = UIButton()
    // Set image
    let image = IconFactory.createSystemIcon(
      "trash.circle",
      color: CustomColor.accent,
      pointSize: 26,
      weight: .bold
    )
    bt.setBackgroundImage(image, for: .normal)
    return bt
  }()
  
  lazy var saveDeleteWrapper = HorizontalStackView(
    arrangedSubviews: [saveButton],
    spacing: 64,
    alignment: .center,
    distribution: .equalCentering
  )
  
  
  
  // MARK: - Content

  let categoryLabel = H3Label(text: "Category")
  let difficultySegment = CustomSegmentedView("Difficulty", [.levelOne, .levelTwo, .levelThree])
  let commandTypeSegment = CustomSegmentedView("Type", [.cToC, .cToA, .cToQ])
  let contentLabel = H3Label(text: "Content")
  lazy var textView: UITextView = {
    let tv = UITextView()
    tv.configureLayout( bgColor: CustomColor.backgroundLower, radius: 18)
    tv.contentInset = .init(top: 16, left: 16, bottom: 16, right: 16)
    tv.font = CustomFont.p
    tv.textColor = CustomColor.subText
    tv.tintColor = CustomColor.accent
    return tv
  } ()

  lazy var stackView: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [
        categoryLabel,
        difficultySegment,
        commandTypeSegment,
        contentLabel,
        textView
      ],
      spacing: 24,
      alignment: .fill,
      distribution: .fill
    )
    sv.setCustomSpacing(16, after: difficultySegment)
    sv.setCustomSpacing(32, after: commandTypeSegment)
    return sv
  } ()
    
  lazy var scrollView = DynamicHeightScrollView(
    contentView: stackView,
    padding: .init(
      top: Constant.Common.topSpacingFromTopLine,
      left: Constant.Common.leadingSpacing,
      bottom: Constant.Common.bottomSpacingFromBottomLine,
      right: Constant.Common.trailingSpacing
    )
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
    configureScrollView()
    configureButtons()
    configureKeyboard()
    backgroundCreator.configureLayout()
    
    configureTextViewBinding()
    configureNavButtonBinding()
  }
}

// MARK: - binding
extension CommandEditViewController {
  func configureTextViewBinding() {
    // If #item reach min, disable delete button.
    viewModel.didReachMinItemRelay
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

  
  private func configureNavButtonBinding() {
    saveButton.rx
      .tap
      .bind { [weak self] _ in
        guard let self = self else { return }
        guard let (detail, difficulty, commandType) = self.validateInput() else { return }
        self.viewModel.createOrUpdateItem(detail, difficulty, commandType)
        self.dismiss(animated: true, completion: nil)
      }
      .disposed(by: viewModel.disposeBag)
    
    deleteButton.rx
      .tap
      .bind { [weak self] _ in
        guard let self = self else { return }
        self.viewModel.deleteSelectedItem()
        self.dismiss(animated: true, completion: nil)
      }
      .disposed(by: viewModel.disposeBag)
    
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    viewModel.dismissSubject.onCompleted()
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
  
  private func configureScrollView() {
    view.configureBgColor(bgColor: CustomColor.background)
    
    scrollView.configureSuperView(under: view)
    scrollView.matchParent(
      padding: .init(
        top: Constant.Common.topLineHeight,
        left: 0,
        bottom: Constant.Common.bottomLineHeight,
        right: 0
      )
    )
    
    // Determine width and height of text view. Otherwise text view will be .zero size
    NSLayoutConstraint.activate([
      textView.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor, multiplier: 1),
      textView.heightAnchor.constraint(equalToConstant: 200)
    ])
    
    // Attributes
    if let command = viewModel.selectedCommand {
      difficultySegment.segmentedControl.selectedSegmentIndex = command .difficulty.rawValue
      commandTypeSegment.segmentedControl.selectedSegmentIndex = command .commandType.rawValue
      textView.text = command.detail
    }
    
  }
  
  private func configureButtons() {
    saveDeleteWrapper.configureSuperView(under: view)
    saveDeleteWrapper.bottomAnchor.constraint(
      equalTo: view.bottomAnchor,
      constant: -Constant.Common.bottomSpacing
    ).isActive = true
    saveDeleteWrapper.centerXin(view)
    
    // If edit mode, add delete button
    if let _ = viewModel.selectedCommand {
      saveDeleteWrapper.insertArrangedSubview(deleteButton, at: 0)
    }
  }
}


// MARK: - Text view

extension CommandEditViewController {
  private func configureKeyboard() {


    let willShownObservable = NotificationCenter.default
      .rx.notification(UIResponder.keyboardWillShowNotification)
      .map { notification -> CGFloat in
        if let height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
          return height
        }
        return 0
      }
    
    let willHideObservable = NotificationCenter.default
      .rx.notification(UIResponder.keyboardWillHideNotification)
      .map { _ -> CGFloat in
        return 0
      }
    
    Observable.of(willShownObservable, willHideObservable)
      .merge()
      .subscribe { [weak self] height in
        self?.scrollView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
      }
      .disposed(by: viewModel.disposeBag)

    
    // Add Gesture: when tap out of keyboard, dismiss
    let tapGesture = UITapGestureRecognizer()
    view.addGestureRecognizer(tapGesture)
    tapGesture.rx.event
      .bind { [weak self] _ in
        self?.view.endEditing(true)
      }
      .disposed(by: viewModel.disposeBag)
  }


}
