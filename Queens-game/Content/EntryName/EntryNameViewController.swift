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
  
  let spacing: CGFloat = 16
  let vm: EntryNameViewModel = EntryNameViewModel()
  let disposeBag: DisposeBag = DisposeBag()
  
  lazy var scrollView = DynamicHeightScrollView(
    contentView: contentWrapper,
    padding: .init(
      top: Constant.Common.topSpacingFromTopLine,
      left: Constant.Common.leadingSpacing,
      bottom: Constant.Common.bottomSpacingFromBottomLine + navButtons.frame.height + spacing,
      right: Constant.Common.trailingSpacing
    )
  )
  
  lazy var contentWrapper: VerticalStackView = {
    let sv = VerticalStackView(arrangedSubviews: [screenTitle])
    sv.spacing = spacing
    sv.alignment = .fill
    sv.distribution = .fill
    sv.setCustomSpacing(40, after: screenTitle)

    return sv
  }()

  let screenTitle: H2Label = {
    let lb = H2Label(text: "Enter Player names")
    lb.lineBreakMode = .byWordWrapping
    lb.numberOfLines = 0
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
    // Do this lastly to add menu button in top layer.
    backgroundCreator.configureLayout()
    
  }
  
  private func configureSuperView() {
    scrollView.configSuperView(under: view)
    contentWrapper.configSuperView(under: scrollView)
    navButtons.configSuperView(under: view)
  }
  
  private func configureNavButtons() {
    navButtons.bottomAnchor.constraint(
      equalTo: view.bottomAnchor,
      constant: -Constant.Common.bottomSpacing
    ).isActive = true
    navButtons.centerXin(view)

    // Load this view to get height.
    navButtons.layoutIfNeeded()
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
        .subscribe(onNext: { [self] value in
          vm.updateUserName(playerId: user.playerId-1, newName: value!)
        })
        .disposed(by: self.disposeBag)
      
      contentWrapper.addArrangedSubview(userInputStackView)
    }
  }
  
}
