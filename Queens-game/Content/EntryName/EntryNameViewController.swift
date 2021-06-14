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
  lazy var backgroundView: BackgroundView = BackgroundViewWithMenu(viewController: self)
  
  let spacing: CGFloat = 16
  let vm: EntryNameViewModel = EntryNameViewModel()
  let disposeBag: DisposeBag = DisposeBag()
  
  let scrollView: UIScrollView = {
    let sv = UIScrollView()
    sv.translatesAutoresizingMaskIntoConstraints = false
    return sv
  }()
  
  lazy var contentWrapper: VerticalStackView = {
    let sv = VerticalStackView(arrangedSubviews: [screenTitle])
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.spacing = spacing
    sv.alignment = .fill
    sv.distribution = .fill
    sv.setCustomSpacing(40, after: screenTitle)

    return sv
  }()

  let screenTitle: H2Label = {
    let lb = H2Label(text: "Enter Player names")
    lb.translatesAutoresizingMaskIntoConstraints = false
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
    GameManager.shared.pushGameProgress(navVC: navigationController!,
                                        currentScreen: self,
                                        nextScreen: nx)
  }
  
  @objc private func goBackToPrevious(_ sender: UIButton) {
    GameManager.shared.popGameProgress(navVC: navigationController!)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    vm.getUsersFromUserDefaults()
    backgroundView.configBackgroundLayout()
    setupLayout()
    createContent()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    setScrollViewInset()
  }
  
  /// Setup whole layout
  private func setupLayout() {
    // config navigation
    navigationItem.hidesBackButton = true
    
    // Add components
    view.backgroundColor = CustomColor.background
    view.addSubview(scrollView)
    view.addSubview(navButtons)
    scrollView.addSubview(contentWrapper)
    
    // set constraints
    scrollView.topAnchor.constraint(equalTo: view.topAnchor,
                                    constant: Constant.Common.topSpacing).isActive = true
    scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                        constant: Constant.Common.leadingSpacing).isActive = true
    scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                         constant:  Constant.Common.trailingSpacing).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

    contentWrapper.anchors(topAnchor: scrollView.contentLayoutGuide.topAnchor,
                              leadingAnchor: scrollView.frameLayoutGuide.leadingAnchor,
                              trailingAnchor: scrollView.frameLayoutGuide.trailingAnchor,
                              bottomAnchor: scrollView.contentLayoutGuide.bottomAnchor)

    navButtons.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                       constant: Constant.Common.bottomSpacing).isActive = true
    navButtons.centerXin(view)
  }
  
  /// Create each EntryyName fields
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
  
  private func setScrollViewInset() {
    let navButtonsHeight: CGFloat = navButtons.nextButton.frame.size.height
    let inset = UIEdgeInsets(top: 0,
                             left: 0,
                             bottom: -Constant.Common.bottomSpacing + navButtonsHeight + spacing,
                             right: 0)
    scrollView.contentInset = inset
  }
}
