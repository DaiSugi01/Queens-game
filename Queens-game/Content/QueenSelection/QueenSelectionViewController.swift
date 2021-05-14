//
//  QueenSelectionViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/09.
//

import UIKit

class QueenSelectionViewController: CommonSelectionViewController {
  
  //TODO: Delete users later
  let users: [User] = [
    User(id: UUID(), playerId: 0, name: "Player1"),
    User(id: UUID(), playerId: 1, name: "Player2"),
    User(id: UUID(), playerId: 2, name: "Player3"),
    User(id: UUID(), playerId: 3, name: "Player4"),
    User(id: UUID(), playerId: 4, name: "Player5"),
    User(id: UUID(), playerId: 5, name: "Player6"),
    User(id: UUID(), playerId: 6, name: "Player7"),
    User(id: UUID(), playerId: 7, name: "Player8"),
    User(id: UUID(), playerId: 8, name: "Player9")
  ]
  
  let vm: QueenSelectionViewModel = QueenSelectionViewModel()
  
  let screenTitle: H2Label = {
    let lb = H2Label(text: "Let's decide the Queen")
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.lineBreakMode = .byWordWrapping
    lb.numberOfLines = 0
    lb.setContentHuggingPriority(.required, for: .vertical)
    return lb
  }()
  
  let navButtons = NextAndBackButtons()
  
  lazy var verticalSV: VerticalStackView = {
    let sv = VerticalStackView(arrangedSubviews: [screenTitle, collectionView])
    sv.alignment = .fill
    sv.distribution = .equalSpacing
    sv.translatesAutoresizingMaskIntoConstraints = false
    return sv
  }()
  
  //TODO: delete unnecessary line "GameManager.shared.users = users" later
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setupLayout()
    setButtonActions()
    GameManager.shared.users = users
  }
  
  /// Setup collection view layout and datasource
  private func setupCollectionView() {
    createCollectionViewLayout()
    createDiffableDataSource(with: Constant.QueenSelection.options)
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
    
    navButtons.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                       constant: Constant.Common.bottomSpacing).isActive = true
    navButtons.centerXin(view)
  }
  
  /// Set Button Actions
  private func setButtonActions() {
    navButtons.nextButton.addTarget(self, action: #selector(goToNext(_:)), for: .touchUpInside)
    navButtons.backButton.addTarget(self, action: #selector(goBackToPrevious(_:)), for: .touchUpInside)
  }
  
  //TODO: Implements card selection later
  
  /// Go to next screen depends on user selection
  /// - Parameter sender: UIButton
  @objc private func goToNext(_ sender: UIButton) {
    guard let indexPath = collectionView.indexPathsForSelectedItems else { return }
    
    switch indexPath {
    case Constant.QueenSelection.quickIndexPath:
      vm.selectQueen()
      let nx = QueenSelectedViewController()
      GameManager.shared.pushGameProgress(navVC: navigationController!,
                                          currentScreen: self,
                                          nextScreen: nx)
    case  Constant.QueenSelection.cardIndexPath:
      print("Path for card selection page")
    default:
      print("None of them are selected")
    }
  }
  
  /// Go back to previous screen
  /// - Parameter sender: UIButton
  @objc private func goBackToPrevious(_ sender: UIButton) {
    GameManager.shared.popGameProgress(navVC: navigationController!)
  }
}
