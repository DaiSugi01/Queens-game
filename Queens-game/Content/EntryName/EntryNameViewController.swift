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
  
  let navButtons: NextAndBackButtons = {
    let bts = NextAndBackButtons()
    bts.nextButton.addTarget(self, action: #selector(goToNext(_:)), for: .touchUpInside)
    bts.backButton.addTarget(self, action: #selector(goBackToPrevious(_:)), for: .touchUpInside)
    
    return bts
  }()
  
  @objc private func goToNext(_ sender: UIButton) {
    // Save user to UserDefaults
    vm.saveUsers()
    
    let nx = QueenSelectionViewController()
    GameManager.shared.pushGameProgress(
      navVC: navigationController!,
      currentScreen: self,
      nextScreen: nx
    )
  }
  
  @objc private func goBackToPrevious(_ sender: UIButton) {
    GameManager.shared.popGameProgress(navVC: navigationController!)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    vm.getUsersFromUserDefaults()
    createContent()
    
    configureSuperView()
    configureNavButtons()
    configureScrollView()
    configureKeyboard()
    // Do this lastly to add menu button in top layer.
    backgroundCreator.configureLayout()
    
  }
  
  private func configureSuperView() {
    scrollView.configSuperView(under: view)
    contentWrapper.configSuperView(under: scrollView)
    navButtons.configSuperView(under: view)
  }
  
  private func configureNavButtons() {
    navButtons.configureLayoutToBottom()
  }
  
  private func configureScrollView() {
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
  
  /// Create each EntryName fields
  private func createContent() {
    // Make each EntryName field
    for user in GameManager.shared.users {
      
      let userInputStackView = EntryNameStackView()
      userInputStackView.configContent(by: user.playerId, and: user.name)
      
      // Observe text field
      userInputStackView.textField.rx.text.asObservable()
        .subscribe(onNext: { [weak self] value in
          self?.vm.updateUserName(playerId: user.playerId-1, newName: value!)
        })
        .disposed(by: vm.disposeBag)
      
      contentWrapper.addArrangedSubview(userInputStackView)
    }
  }
  
}

extension EntryNameViewController {
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
