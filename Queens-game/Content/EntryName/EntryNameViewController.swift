//
//  EntryNameCollectionViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit
import RxSwift
import RxCocoa

class EntryNameViewController: UIViewController, QueensGameViewControllerProtocol {
  
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorWithMenu(viewController: self)
  
  let vm: EntryNameViewModel = EntryNameViewModel()
  
  lazy var scrollView = DynamicHeightScrollView(
    contentView: contentWrapper,
    padding: .init(
      top: Constant.Common.topSpacingFromTopLine,
      left: Constant.Common.leadingSpacing,
      bottom: Constant.Common.bottomSpacingFromBottomLine + 80,
      right: Constant.Common.trailingSpacing
    )
  )
  
  lazy var contentWrapper: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [screenTitle],
      spacing: 16
    )
    sv.setCustomSpacing(Constant.Common.topSpacingFromTitle, after: screenTitle)
    
    return sv
  }()
  
  let screenTitle: H2Label = {
    let lb = H2Label(text: "Enter player's name")
    lb.lineBreakMode = .byWordWrapping
    lb.setContentHuggingPriority(.required, for: .vertical)
    return lb
  }()
  
  let navButtons = NextAndBackButtons()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    vm.getUsersFromUserDefaults()
    configureTextFields()
    
    configureLayout()
    configureNavButtonBindings()
    configureKeyboardBinding()
    
    backgroundCreator.configureLayout()
    
  }
  
}


// MARK: - Text Fields

extension EntryNameViewController {
  
  /// Create each EntryName fields
  private func configureTextFields() {
    // Make each EntryName field
    for user in GameManager.shared.users {
      
      let userInputStackView = EntryNameStackView()
      userInputStackView.configContent(by: user.playerId, and: user.name)
      
      // Observe text field
      userInputStackView.textField.rx
        .text
        .subscribe(onNext: { [weak self] value in
          guard let self = self, let value = value else { return }
          self.vm.updateUserName(playerId: user.playerId - 1, newName: value)
        })
        .disposed(by: vm.disposeBag)
      
      contentWrapper.addArrangedSubview(userInputStackView)
    }
  }
  
}


// MARK: - Layout

extension EntryNameViewController {
  
  private func configureLayout() {
    scrollView.configureSuperView(under: view)
    contentWrapper.configureSuperView(under: scrollView)
    navButtons.configureSuperView(under: view)
    
    navButtons.configureLayoutToBottom()
    
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


// MARK: - Bindings

extension EntryNameViewController {
  
  private func configureNavButtonBindings() {
    navButtons.nextButton.rx
      .tap
      .bind { [weak self] _ in
        guard let self = self else { return }
        // Save user to UserDefaults
        self.vm.saveUsers()
        let nx = QueenSelectionViewController()
        GameManager.shared.pushGameProgress(
          navVC: self.navigationController!,
          currentScreen: self,
          nextScreen: nx
        )
      }
      .disposed(by: vm.disposeBag)
    
    navButtons.backButton.rx
      .tap
      .bind { [weak self] _ in
        GameManager.shared.popGameProgress(navVC: self?.navigationController!)
      }
      .disposed(by: vm.disposeBag)
  }
  
  private func configureKeyboardBinding() {
    
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
      .disposed(by: vm.disposeBag)
    
    
    // Add Gesture: when tap out of keyboard, dismiss
    let tapGesture = UITapGestureRecognizer()
    view.addGestureRecognizer(tapGesture)
    tapGesture.rx.event
      .bind { [weak self] _ in
        self?.view.endEditing(true)
      }
      .disposed(by: vm.disposeBag)
  }
  
}

