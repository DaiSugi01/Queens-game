//
//  QueenSelectionViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/09.
//  Updated by Tak

import UIKit

class QueenSelectionViewController: CommonSelectionViewController, QueensGameViewControllerProtocol {
  
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorWithMenu(viewController: self)

  let vm: QueenSelectionViewModel = QueenSelectionViewModel()
  
  let navButtons = NextAndBackButtons()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    configureLayout()
    configureButtonActions()
    backgroundCreator.configureLayout()
  }
  
  /// Setup collection view layout and datasource
  private func configureCollectionView() {
    createCollectionViewLayout()
    createDiffableDataSource(
      with: Constant.QueenSelection.options,
      and: Constant.QueenSelection.title
    )
    
    // Select first item by default
    guard let sectionIndex = sections.firstIndex(of: .selection) else { return }
    collectionView.selectItem(
      at: IndexPath(row: 0, section: sectionIndex),
      animated: false,
      scrollPosition: .top
    )
  }
  
  /// Setup whole layout
  private func configureLayout() {
    // configure superview
    collectionView.configSuperView(under: view)
    navButtons.configSuperView(under: view)
    
    // collection view
    collectionView.matchParent(
      padding: .init(
        top: Constant.Common.topSpacing/2,
        left: 0,
        bottom: -Constant.Common.bottomSpacing/2,
        right: 0
      )
    )
    collectionView.contentInset = .init(
      top: Constant.Common.topSpacing/2,
      left: 0,
      bottom: -Constant.Common.bottomSpacing/2,
      right: 0
    )

    // Buttons
    navButtons.bottomAnchor.constraint(
      equalTo: view.bottomAnchor,
      constant: Constant.Common.bottomSpacing
    ).isActive = true
    navButtons.centerXin(view)
  }
  
  /// Set Button Actions
  private func configureButtonActions() {
    navButtons.nextButton.addTarget(
      self,
      action: #selector(goToNext(_:)),
      for: .touchUpInside
    )
    navButtons.backButton.addTarget(
      self,
      action: #selector(goBackToPrevious(_:)),
      for: .touchUpInside
    )
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
      GameManager.shared.pushGameProgress(
        navVC: navigationController,
        currentScreen: self,
        nextScreen: nx
      )
    case  Constant.QueenSelection.cardIndexPath:
      print("Path for card selection page")
    default:
      print("None of them are selected")
    }
  }
  
  /// Go back to previous screen
  /// - Parameter sender: UIButton
  @objc private func goBackToPrevious(_ sender: UIButton) {
    GameManager.shared.popGameProgress(navVC: navigationController)
  }
}
