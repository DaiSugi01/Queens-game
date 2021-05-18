//
//  EntryNameCollectionViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit
import RxSwift
import RxCocoa

class EntryNameViewController: UIViewController {
  
  let vm = EntryNameViewModel()
  let disposeBag: DisposeBag = DisposeBag()
  
  lazy var verticalSV: VerticalStackView = {
    let sv = VerticalStackView(arrangedSubviews: [screenTitle, scrollView])
    sv.alignment = .fill
    sv.distribution = .equalSpacing
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.spacing = 40
    
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
  
  let scrollView: UIScrollView = {
    let sv = UIScrollView()
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.constraintHeight(equalToConstant: 360)
    
    return sv
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
    
    let nx = QueenSelectedViewController()
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
    setupLayout()
    createContent()
  }
  
  /// Setup whole layout
  private func setupLayout() {
    // config navigation
    navigationItem.hidesBackButton = true
    
    // add components to super view
    view.backgroundColor = CustomColor.background
    view.addSubview(verticalSV)
    view.addSubview(navButtons)
    
    // set constraints
    verticalSV.topAnchor.constraint(equalTo: view.topAnchor,
                                    constant: Constant.Common.topSpacing).isActive = true
    verticalSV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                        constant: Constant.Common.leadingSpacing).isActive = true
    verticalSV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                         constant:  Constant.Common.trailingSpacing).isActive = true
    
    navButtons.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:
                                        Constant.Common.bottomSpacing).isActive = true
    navButtons.centerXin(view)
  }
  
  /// Create each EntryyName fields
  private func createContent() {
    let scrollViewWrapper: VerticalStackView = VerticalStackView(arrangedSubviews: [])
    scrollView.addSubview(scrollViewWrapper)
    
    scrollViewWrapper.translatesAutoresizingMaskIntoConstraints = false
    scrollViewWrapper.spacing = 16
    scrollViewWrapper.alignment = .fill
    scrollViewWrapper.distribution = .fill
    scrollViewWrapper.anchors(topAnchor: scrollView.contentLayoutGuide.topAnchor,
                              leadingAnchor: scrollView.frameLayoutGuide.leadingAnchor,
                              trailingAnchor: scrollView.frameLayoutGuide.trailingAnchor,
                              bottomAnchor: scrollView.contentLayoutGuide.bottomAnchor)
    
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
      
      scrollViewWrapper.addArrangedSubview(userInputStackView)
    }
  }
}
